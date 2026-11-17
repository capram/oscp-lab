# Security Policy

## Repository Purpose

This repository is intended to store:

- Workstation build scripts
- Tool installation scripts
- Configuration files
- Automation utilities
- Playbooks and methodology
- Obsidian templates
- Documentation

The repository should be sufficient to rebuild an OSCP workstation from a fresh Kali installation.

---

## Never Commit Sensitive Information

The following items must never be committed to this repository:

### Credentials

- Passwords
- API keys
- Access tokens
- Session tokens
- MFA recovery codes

### Private Keys and Certificates

- SSH private keys
- VPN certificates
- TLS private keys
- PKCS12 / PFX files

### Lab and Client Data

- VPN configuration files
- Loot
- Credential dumps
- Password hashes
- Screenshots containing sensitive information
- Packet captures (PCAPs)
- Client deliverables
- Client reports
- Client data

### Certification Materials

- Exam content
- Exam notes
- Exam questions
- Restricted training material

---

## Repository Philosophy

Store the process, not the results.

Good examples:

- Build scripts
- Automation
- Configuration
- Checklists
- Methodology
- Templates

Bad examples:

- Credentials
- Loot
- Shell history
- Active lab data
- Sensitive screenshots

---

## Before Every Commit

Review changes before pushing:

git status

git diff

git add .

git commit \-m "description"

git push

Validate that no sensitive files are included in the commit.

---

## Responsible Use

This repository is maintained for authorized training, laboratory work, research, and professional development.

Users are responsible for ensuring all activities comply with applicable laws, regulations, organizational policies, and rules of engagement.

---

## Recovery Goal

If a workstation is lost or rebuilt, this repository should provide everything necessary to recreate the environment without exposing any sensitive information.

