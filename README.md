# Performance-Benchmark-Tool
Perl script to benchmark system performance, including CPU, Disk I/O, Memory, and Network metrics. Designed for system administrators, developers.Helps manage system performance and identify bottlenecks

Performance Benchmarking Tool

A lightweight and modular Perl script to benchmark system and application performance. This tool measures CPU, Disk I/O, Memory, Network, and Application performance, providing valuable insights for system administrators, developers, and DevOps engineers.
Features

    CPU Benchmark: Measures CPU performance using sysbench.

    Disk I/O Benchmark: Tests disk read/write speeds using dd.

    Memory Benchmark: Evaluates memory performance using sysbench.

    Network Benchmark: Tests network throughput using iperf.

    Application Benchmark: Measures application performance using ab (Apache Benchmark).

    Customizable Parameters: Adjust benchmark settings via command-line options.

    Modular Design: Easy to extend and maintain.

Requirements

    Perl 5.x

    sysbench: For CPU and memory benchmarks.

    iperf: For network benchmarking (optional).

    ab (Apache Benchmark): For application benchmarking (optional).

Installation

    Clone the Repository:
    bash
    Copy

    git clone https://github.com/yourusername/performance-benchmarking-tool.git
    cd performance-benchmarking-tool

    Install Dependencies:

        On Debian/Ubuntu:
        sudo apt update
        sudo apt install perl sysbench iperf apache2-utils

    Make the Script Executable:
    bash
    Copy

    chmod +x benchmark.pl

Usage
Basic Usage

Run the script with default settings:
bash
Copy

./benchmark.pl

Custom Benchmarks

Customize benchmarks using command-line options:
bash
Copy

./benchmark.pl \
  --cpu-prime=50000 \
  --disk-size=2G \
  --memory-size=20G \
  --iperf-server=192.168.1.100 \
  --app-url=http://localhost:5000

Command-Line Options
Option	Description	Default Value
--cpu-prime	Max prime number for CPU benchmark	20000
--disk-size	File size for Disk I/O benchmark	1G
--memory-size	Total size for Memory benchmark	10G
--iperf-server	IP address of the iperf server	N/A
--app-url	URL of the application to benchmark	N/A
--help	Display help message	N/A
Example Output
Copy

Starting Performance Benchmarking Tool...

Running CPU benchmark...
CPU Benchmark Result:
[sysbench output...]
CPU Time: 12.345 seconds

Running Disk I/O benchmark...
Disk I/O Benchmark Result:
[dd output...]
Disk I/O Time: 5.678 seconds

Running Memory benchmark...
Memory Benchmark Result:
[sysbench output...]
Memory Time: 7.890 seconds

Running Network benchmark...
Network Benchmark Result:
[iperf output...]
Network Time: 3.456 seconds

Running Application benchmark...
Application Benchmark Result:
[ab output...]
Application Time: 4.321 seconds

=== Performance Benchmarking Report ===
CPU Time: 12.345 seconds
Disk I/O Time: 5.678 seconds
Memory Time: 7.890 seconds
Network Time: 3.456 seconds
Application Time: 4.321 seconds

Benchmarking completed!

Extending the Tool
Adding New Benchmarks

    Create a new subroutine for the benchmark (e.g., benchmark_gpu).

    Add the benchmark to the main script:
    perl
    Copy

    my $gpu_time = benchmark_gpu();

    Update the generate_report subroutine to include the new benchmark.

Example: Adding a GPU Benchmark
