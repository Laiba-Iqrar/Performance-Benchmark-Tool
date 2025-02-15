#!/usr/bin/perl
use strict;
use warnings;
use Time::HiRes qw(gettimeofday);
use Getopt::Long;

# Default benchmark parameters
my $cpu_prime = 20000;       # CPU benchmark: max prime number
my $disk_size = "1G";        # Disk I/O benchmark: file size
my $memory_size = "10G";     # Memory benchmark: total size
my $iperf_server = "";       # iperf server for network benchmark
my $app_url = "";            # Application URL for benchmarking
my $help = 0;                # Help flag

# Parse command-line options
GetOptions(
    "cpu-prime=i"   => \$cpu_prime,
    "disk-size=s"   => \$disk_size,
    "memory-size=s" => \$memory_size,
    "iperf-server=s" => \$iperf_server,
    "app-url=s"     => \$app_url,
    "help"          => \$help,
);

# Display help and exit if --help is provided
if ($help) {
    print <<"HELP";
Performance Benchmarking Tool

Usage: $0 [options]

Options:
    --cpu-prime=N      Set the max prime number for CPU benchmark (default: 20000)
    --disk-size=SIZE   Set the file size for Disk I/O benchmark (default: 1G)
    --memory-size=SIZE Set the total size for Memory benchmark (default: 10G)
    --iperf-server=IP  Specify the iperf server for network benchmark
    --app-url=URL      Specify the application URL for benchmarking
    --help             Display this help message
HELP
    exit;
}

# Function to benchmark CPU
sub benchmark_cpu {
    print "Running CPU benchmark...\n";
    my $start_time = gettimeofday;
    my $result = `sysbench cpu --cpu-max-prime=$cpu_prime run`;
    my $end_time = gettimeofday;
    my $cpu_time = $end_time - $start_time;
    print "CPU Benchmark Result:\n$result\n";
    print "CPU Time: $cpu_time seconds\n\n";
    return $cpu_time;
}

# Function to benchmark Disk I/O
sub benchmark_disk {
    print "Running Disk I/O benchmark...\n";
    my $start_time = gettimeofday;
    my $result = `dd if=/dev/zero of=tempfile bs=$disk_size count=1 2>&1`;
    my $end_time = gettimeofday;
    my $disk_time = $end_time - $start_time;
    print "Disk I/O Benchmark Result:\n$result\n";
    print "Disk I/O Time: $disk_time seconds\n\n";
    unlink "tempfile"; # Clean up
    return $disk_time;
}

# Function to benchmark Memory
sub benchmark_memory {
    print "Running Memory benchmark...\n";
    my $start_time = gettimeofday;
    my $result = `sysbench memory --memory-block-size=1K --memory-total-size=$memory_size run`;
    my $end_time = gettimeofday;
    my $memory_time = $end_time - $start_time;
    print "Memory Benchmark Result:\n$result\n";
    print "Memory Time: $memory_time seconds\n\n";
    return $memory_time;
}

# Function to benchmark Network using iperf
sub benchmark_network {
    my ($server) = @_;
    unless ($server) {
        print "Skipping Network benchmark (no iperf server specified).\n\n";
        return "N/A";
    }
    print "Running Network benchmark...\n";
    my $start_time = gettimeofday;
    my $result = `iperf -c $server`;
    my $end_time = gettimeofday;
    my $network_time = $end_time - $start_time;
    print "Network Benchmark Result:\n$result\n";
    print "Network Time: $network_time seconds\n\n";
    return $network_time;
}

# Function to benchmark Application
sub benchmark_application {
    my ($url) = @_;
    unless ($url) {
        print "Skipping Application benchmark (no URL specified).\n\n";
        return "N/A";
    }
    print "Running Application benchmark...\n";
    my $start_time = gettimeofday;
    my $result = `ab -n 1000 -c 100 $url`; # 1000 requests, 100 concurrent connections
    my $end_time = gettimeofday;
    my $app_time = $end_time - $start_time;
    print "Application Benchmark Result:\n$result\n";
    print "Application Time: $app_time seconds\n\n";
    return $app_time;
}

# Function to generate a report
sub generate_report {
    my ($cpu_time, $disk_time, $memory_time, $network_time, $app_time) = @_;
    my $report = <<"REPORT";
=== Performance Benchmarking Report ===
CPU Time: $cpu_time seconds
Disk I/O Time: $disk_time seconds
Memory Time: $memory_time seconds
Network Time: $network_time seconds
Application Time: $app_time seconds
REPORT
    return $report;
}

# Main script
print "Starting Performance Benchmarking Tool...\n\n";

# Run benchmarks
my $cpu_time = benchmark_cpu();
my $disk_time = benchmark_disk();
my $memory_time = benchmark_memory();
my $network_time = benchmark_network($iperf_server);
my $app_time = benchmark_application($app_url);

# Generate and print report
my $report = generate_report($cpu_time, $disk_time, $memory_time, $network_time, $app_time);
print $report;

print "Benchmarking completed!\n";