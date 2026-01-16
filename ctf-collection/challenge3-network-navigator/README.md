# Challenge 3: Network Navigator

**Difficulty:** Medium  
**Skills:** Network analysis, netstat, ss, curl, wget, DNS

## Challenge Description

You've been given a network configuration file with various connection details. Your task is to analyze the network information, understand the connections, and retrieve the flag from a remote source. This challenge tests your ability to work with network commands and understand network configurations.

## Objective

Analyze the network configuration and retrieve the flag. The flag format is: `FLAG{...}`

## Setup

Run the setup script:
```bash
bash setup.sh
```

This will create network configuration files and start a simple local web server with the flag.

## Hints

<details>
<summary>Hint 1 (Click to reveal)</summary>

Check the `network_config.txt` file for connection details.
</details>

<details>
<summary>Hint 2 (Click to reveal)</summary>

Use `curl` or `wget` to retrieve content from HTTP URLs.
</details>

<details>
<summary>Hint 3 (Click to reveal)</summary>

The file contains a localhost URL. Try accessing it with curl.
</details>

<details>
<summary>Solution (Click to reveal)</summary>

```bash
# Check the network configuration
cat network_config.txt

# Find the URL in the file
grep -i "url\|http" network_config.txt

# Access the URL (typically http://localhost:8888/flag.txt)
curl http://localhost:8888/flag.txt

# Or use wget
wget -qO- http://localhost:8888/flag.txt
```
</details>

## Cheat Sheet

### Network Information Commands

```bash
# Show all network connections
netstat -a

# Show listening ports
netstat -l

# Show listening TCP ports with program names
netstat -tlpn

# Show listening UDP ports
netstat -ulpn

# Show all connections with program names
netstat -tupn

# Modern replacement for netstat
ss -tulpn

# Show all sockets
ss -a

# Show TCP sockets
ss -t

# Show UDP sockets
ss -u
```

### DNS and Host Information

```bash
# Lookup IP address of a domain
nslookup domain.com

# DNS lookup with more details
dig domain.com

# Simple DNS lookup
host domain.com

# Reverse DNS lookup
dig -x IP_ADDRESS

# Show all DNS records
dig domain.com ANY
```

### Network Testing

```bash
# Test connectivity to host
ping hostname

# Ping with specific count
ping -c 4 hostname

# Trace route to destination
traceroute hostname
tracepath hostname

# Show network route table
route -n
ip route show

# Test if port is open
telnet hostname port
nc -zv hostname port
```

### Downloading Files

```bash
# Download file with curl
curl -O URL

# Download and save with specific name
curl -o filename URL

# Follow redirects
curl -L URL

# Show only output (silent mode)
curl -s URL

# Show headers
curl -I URL

# Download with wget
wget URL

# Download silently to stdout
wget -qO- URL

# Download with custom filename
wget -O filename URL

# Continue interrupted download
wget -c URL
```

### HTTP Requests

```bash
# Make GET request
curl http://example.com

# Make POST request
curl -X POST -d "data=value" http://example.com

# Send JSON data
curl -X POST -H "Content-Type: application/json" -d '{"key":"value"}' URL

# Follow redirects
curl -L URL

# Save cookies
curl -c cookies.txt URL

# Send cookies
curl -b cookies.txt URL

# Custom headers
curl -H "Header: Value" URL

# Basic authentication
curl -u username:password URL
```

### Network Interface Information

```bash
# Show all network interfaces
ifconfig
ip addr show

# Show specific interface
ifconfig eth0
ip addr show eth0

# Show interface statistics
ip -s link

# Show routing table
ip route

# Show ARP cache
arp -a
ip neigh show
```

### Port Scanning

```bash
# Scan ports with nmap (if installed)
nmap hostname

# Scan specific ports
nmap -p 80,443 hostname

# Scan port range
nmap -p 1-1000 hostname

# Check if port is open with netcat
nc -zv hostname port

# Check TCP connection
timeout 1 bash -c "</dev/tcp/hostname/port" && echo "Port open"
```

### Local Network Services

```bash
# List open files and network connections
lsof -i

# Show processes using port
lsof -i :port

# Show all network connections by process
lsof -i -P -n

# Show connections for specific user
lsof -i -u username
```

### Useful Network Files

```bash
# View DNS servers
cat /etc/resolv.conf

# View hosts file
cat /etc/hosts

# View network interfaces
cat /etc/network/interfaces

# View hostname
hostname
cat /etc/hostname
```

### Testing Web Services

```bash
# Check HTTP response code
curl -I -s http://example.com | head -n 1

# Time the request
curl -w "@-" -o /dev/null -s http://example.com << 'EOF'
    time_namelookup:  %{time_namelookup}\n
       time_connect:  %{time_connect}\n
          time_total:  %{time_total}\n
EOF

# Check if website is up
curl -Is http://example.com | head -n 1

# Fetch with timeout
curl --max-time 5 URL

# Verbose output for debugging
curl -v URL
```

### Useful Tips

- **localhost** and **127.0.0.1** refer to your own machine
- **Port 80** is default for HTTP
- **Port 443** is default for HTTPS
- **Port 22** is default for SSH
- Use `-v` (verbose) flag for debugging connection issues
- Many commands require `sudo` for full functionality

### Common Ports

- **20, 21** - FTP
- **22** - SSH
- **23** - Telnet
- **25** - SMTP
- **53** - DNS
- **80** - HTTP
- **443** - HTTPS
- **3306** - MySQL
- **5432** - PostgreSQL
- **8080** - Alternative HTTP

## What You Learned

After completing this challenge, you should understand:
- How to analyze network configurations
- Using curl and wget to retrieve remote content
- Understanding network commands like netstat and ss
- Working with localhost and ports
- Basic HTTP request/response concepts
- How to test network connectivity

---

**Previous Challenge:** [Challenge 2: Process Detective](../challenge2-process-detective/)  
**Next Challenge:** [Challenge 4: Log File Forensics](../challenge4-log-forensics/)
