# Performance-Benchmark-Tool
Perl script to benchmark system performance, including CPU, Disk I/O, Memory, and Network metrics. Designed for system administrators, developers.Helps manage system performance and identify bottlenecks


## **Features**

- **CPU Benchmark**: Measures CPU performance using `sysbench`.
- **Disk I/O Benchmark**: Tests disk read/write speeds using `dd`.
- **Memory Benchmark**: Evaluates memory performance using `sysbench`.
- **Network Benchmark**: Tests network throughput using `iperf`.
- **Application Benchmark**: Measures application performance using `ab` (Apache Benchmark).

---

## **Requirements**

- **Perl 5.x**
- **sysbench**: For CPU and memory benchmarks.
- **iperf**: For network benchmarking (optional).
- **ab (Apache Benchmark)**: For application benchmarking (optional).

---


 **Install Dependencies**:
   - On **Debian/Ubuntu**:
     ```bash
     sudo apt update
     sudo apt install perl sysbench iperf apache2-utils
     ```
 **Make the Script Executable**:
   ```bash
   chmod +x benchmark.pl
   ```

---

## **Usage**

Run the script with default settings:
```bash
./benchmark.pl
```

### **Custom Benchmarks**
Customize benchmarks using command-line options:
```bash
./benchmark.pl \
  --cpu-prime=50000 \
  --disk-size=2G \
  --memory-size=20G \
  --iperf-server=192.168.1.100 \
  --app-url=http://localhost:5000
```

### **Command-Line Options**
| Option            | Description                                  | Default Value |
|-------------------|----------------------------------------------|---------------|
| `--cpu-prime`     | Max prime number for CPU benchmark           | 20000         |
| `--disk-size`     | File size for Disk I/O benchmark             | 1G            |
| `--memory-size`   | Total size for Memory benchmark              | 10G           |
| `--iperf-server`  | IP address of the `iperf` server             | N/A           |
| `--app-url`       | URL of the application to benchmark          | N/A           |
| `--help`          | Display help message                         | N/A           |

### **Example Output**
```

=== Performance Benchmarking Report ===
CPU Time: 12.345 seconds
Disk I/O Time: 5.678 seconds
Memory Time: 7.890 seconds
Network Time: 3.456 seconds
Application Time: 4.321 seconds

Benchmarking completed!
```

---

## **Extending the Tool**

### **Adding New Benchmarks**
1. Create a new subroutine for the benchmark (e.g., `benchmark_gpu`).
2. Add the benchmark to the main script:
   ```perl
   my $gpu_time = benchmark_gpu();
   ```
3. Update the `generate_report` subroutine to include the new benchmark.

### **Example: Adding a GPU Benchmark**
```perl
sub benchmark_gpu {
    print "Running GPU benchmark...\n";
    my $start_time = gettimeofday;
    my $result = `gpustat`; # Example command
    my $end_time = gettimeofday;
    my $gpu_time = $end_time - $start_time;
    print "GPU Benchmark Result:\n$result\n";
    print "GPU Time: $gpu_time seconds\n\n";
    return $gpu_time;
}
```

---

## **Contributing**

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch:
   ```bash
   git checkout -b feature/new-benchmark
   ```
3. Commit your changes:
   ```bash
   git commit -m "Add new GPU benchmark"
   ```
4. Push to the branch:
   ```bash
   git push origin feature/new-benchmark
   ```
5. Open a pull request.

---
