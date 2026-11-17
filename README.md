# OSCP Lab

Personal workstation build, tooling, methodology, and knowledge management repository for OSCP, Proving Grounds, Hack The Box, Active Directory labs, and general offensive security research.

The goal of this repository is simple:

Rebuild a complete OSCP workstation from a fresh Kali installation with a single repository and a small number of scripts.

---

## Repository Structure

oscp\-lab

│

├── build

│   ├── 01\-bootstrap.sh

│   ├── 02\-toolkit.sh

│   ├── 03\-python\-toolkit.sh

│   ├── 04\-obsidian.sh

│   └── rebuild.sh

│

├── configs

│

├── docs

│

├── obsidian

│

├── playbooks

│

└── scripts

### build/

Contains provisioning scripts used to configure a new Kali workstation.

### configs/

Stores reusable configuration files such as:

- Bash aliases
- Terminator configuration
- Sublime Text configuration

### scripts/

Personal automation scripts.

Examples:

- Nmap automation
- SMB enumeration helpers
- Web enumeration helpers
- Utility scripts

### playbooks/

Repeatable methodologies and checklists.

Examples:

- Active Directory Enumeration
- Linux Enumeration
- Windows Enumeration
- Privilege Escalation
- Reporting

### obsidian/

Templates and vault starter content used when creating a new Obsidian vault.

### docs/

Supporting documentation for workstation setup and maintenance.

---

## Workstation Build Process

### 1\. Clone Repository

git clone [https://github.com/capram/oscp\-lab.git](https://github.com/capram/oscp-lab.git)

cd oscp\-lab

### 2\. Make Scripts Executable

chmod \+x build/\*.sh

### 3\. Run Full Build

./build/rebuild.sh

The rebuild process is intended to:

- Update Kali
- Install workstation software
- Configure aliases
- Install security tooling
- Create Python virtual environments
- Install Obsidian
- Create OSCP directory structure
- Import templates and configurations

---

## Target Directory Structure

The workstation should ultimately create:

~/OSCP

├── Active

├── AD

├── Linux

├── Windows

├── Scans

├── Loot

├── Exploits

├── Tools

├── Reports

├── Screenshots

├── Wordlists

├── Notes

└── venvs

---

## Design Principles

### Reproducible

A workstation should be recoverable from source control.

### Documented

Procedures should be written down and repeatable.

### Version Controlled

Scripts, playbooks, templates, and configurations belong in Git.

### Disposable

A VM should be considered replaceable. Rebuilding should be faster than troubleshooting a heavily modified environment.

---

## Not Stored In This Repository

The following should never be committed:

- Credentials
- VPN configurations
- Loot
- Screenshots
- PCAP files
- Exam materials
- Client data
- Private notes

---

## Future Roadmap

- Automated workstation provisioning
- Obsidian vault deployment
- Templater support
- Tool version validation
- Custom enumeration scripts
- Playbook library
- Report templates
- HTB / PG workflow integration

---

## Philosophy

Build systems, not heroics.

If a workstation is lost, compromised, corrupted, or rebuilt, everything required to get back to work should already exist in source control.

