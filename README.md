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
Active Directory installatiion and creating domain user ansible and add it to 

all joined to the domain (ITI.LOCAL)
Ansible will connect to windows servers through winrm service on windows servers (opened ports 5985) 

