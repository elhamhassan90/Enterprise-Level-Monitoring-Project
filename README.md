# nterprise-Level-Monitoring-Project
Monitoring + AD Integration + Linux Domain Join + Windows Exporter + Linux Exporter + Ansible Automation

## Architecure
 VM1 → Windows Server (192.168.142.100)
       + Active Directory (Domain Controller) 
       + Windows Exporter (via Ansible)

 VM2 → Linux Server (192.168.142.222)
       + Ansible
       + Prometheus
       + Grafana
 
 VM3 → Linux Server 
       + Node Exporter (via Ansible)

## Quick architecture (what we have)

VM1 (Control) — Ansible controller + Prometheus + Grafana

VM2 (AD / DC) — Windows Server running Active Directory + DNS (domain controller) 

VM3 (Linux node) — target Linux (Node Exporter) — joined to AD

VM4 (Windows node) — target Windows (windows_exporter) — joined to AD

## Preparing Environment
**Preparing Windows Vms**
Active Directory installatiion, joining windows server to domain (ITI.LOCAL) and creating domain user ansible   
- Ansible will connect to windows servers through winrm service on windows servers (opened ports 5985) 
- user ansible can login to all windows servers joined the domain 

Add gpo (ansible-gpo) that will add ansible user to the the local administrators group on all windows servers joined to the domain and then deny it from local and remote login to all windows servers
 create OU called All-Windows-Servers  and link the gpo (ansible-gpo) to it 
---
Computer Configuration → Preferences → Control Panel Settings → Local Users and Groups → New → Local Group (Administrators) *and add ansible user to this group*
---
Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies → User Rights Assignment → Deny log on locally *and add ansible user to this group*
---
Computer Configuration → Policies → Windows Settings → Security Settings → Local Policies → User Rights Assignment → Deny log on through Remote Desktop Services *and add ansible user to this group*
---
- after applying the group policy the ansible user cannot login the windows servers

**Preparing Linux Vms**


