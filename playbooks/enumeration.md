# Enumeration

This is the standard enumeration methodology for OSCP, Proving Grounds, Hack The Box, and lab environments.

---

# Step 1 - Create Target Workspace

Use the workflow script.

```bash
new_target.sh
```

Provide:

- Machine Name
- Target IP

Expected structure:

```text
~/OSCP/Active/<MachineName>
├── scans
├── loot
├── exploits
├── screenshots
└── notes
```

---

# Step 2 - Launch Initial Reconnaissance

Run:

```bash
autorecon <IP>
```

Or:

```bash
full_scan.sh <IP>
```

Expected outputs:

- Full TCP Scan
- Service Detection
- NSE Results
- Basic Enumeration

---

# Common Services

Review every discovered port.

---

# FTP (21)

## Check Banner

```bash
nc -nv TARGET 21
```

## Anonymous Access

```bash
ftp TARGET
```

Username:

```text
anonymous
```

## Additional

- Download files
- Check source code
- Check backups
- Check credentials

---

# SSH (22)

## Version

```bash
ssh TARGET
```

## Enumeration

- Username discovery
- Credential reuse
- Private key usage
- Weak passwords

---

# DNS (53)

## Zone Transfer

```bash
dig axfr @TARGET DOMAIN
```

## Enumeration

```bash
dnsrecon -d DOMAIN
```

```bash
dnsenum DOMAIN
```

---

# HTTP / HTTPS (80,443,8080,8443)

## Browser Review

Inspect:

- Login pages
- Source code
- Robots.txt
- Sitemap.xml

## Feroxbuster

```bash
feroxbuster -u http://TARGET
```

## FFUF

```bash
ffuf -u http://TARGET/FUZZ \
-w /usr/share/seclists/Discovery/Web-Content/common.txt
```

## Nikto

```bash
nikto -h http://TARGET
```

---

# SMB (139,445)

## Shares

```bash
nxc smb TARGET --shares
```

## Users

```bash
enum4linux-ng TARGET
```

## Null Sessions

```bash
smbclient -L //TARGET -N
```

Look for:

- Readable shares
- Credentials
- Scripts
- Source code
- Backups

---

# RPC (111)

## Enumeration

```bash
rpcinfo -p TARGET
```

Check:

- NFS exports
- RPC programs

---

# NFS (2049)

## List Exports

```bash
showmount -e TARGET
```

## Mount Share

```bash
sudo mount -t nfs TARGET:/share /mnt/nfs
```

Look for:

- SSH Keys
- User files
- Credentials

---

# LDAP (389)

## Anonymous Bind

```bash
ldapsearch -x -H ldap://TARGET
```

## Naming Contexts

```bash
ldapsearch -x -H ldap://TARGET -s base
```

Collect:

- Users
- Groups
- Descriptions
- Password hints

---

# LDAPS (636)

Perform all LDAP testing over SSL.

---

# Kerberos (88)

## User Enumeration

```bash
kerbrute userenum
```

## ASREP Roasting

```bash
GetNPUsers.py
```

## Kerberoasting

```bash
GetUserSPNs.py
```

---

# WinRM (5985 / 5986)

## Access Test

```bash
evil-winrm
```

Check:

- Reused credentials
- Domain credentials

---

# MSSQL (1433)

## Anonymous Access

```bash
nxc mssql TARGET
```

## Common Accounts

```bash
sa
```

Check:

- xp_cmdshell
- Linked servers

---

# MySQL (3306)

## Connection Test

```bash
mysql -h TARGET -u root
```

Check:

- Empty passwords
- Application credentials

---

# PostgreSQL (5432)

## Connection Test

```bash
psql -h TARGET
```

Check:

- Database credentials
- Password reuse

---

# RDP (3389)

## Test Access

```bash
xfreerdp
```

Verify:

- Domain credentials
- Local credentials

---

# Active Directory Indicators

If you see:

```text
53
88
135
139
389
445
464
593
636
3268
3269
```

Treat the target as Active Directory.

Run:

```bash
ad_target.sh
```

Additional Collection:

```bash
bloodhound-python
```

```bash
ldapdomaindump
```

```bash
nxc smb
```

---

# Enumeration Checklist

- [ ] Full TCP Scan
- [ ] Service Detection
- [ ] SMB Reviewed
- [ ] Web Reviewed
- [ ] LDAP Reviewed
- [ ] Kerberos Reviewed
- [ ] NFS Reviewed
- [ ] RPC Reviewed
- [ ] Credentials Collected
- [ ] Attack Paths Identified

---

# Rule

Do not exploit until enumeration is complete.

Missed enumeration causes more failures than missed exploits.
