# nterprise-Level-Monitoring-Project
Monitoring + AD Integration + Linux Domain Join + Windows Exporter + Linux Exporter + Ansible Automation

## Architecure
 VM1 → Windows Server (192.168.142.100)
       + Active Directory (Domain Controller)
       + Windows Exporter (via Ansible)

 VM2 → Linux Server (192.168.142.100)
       + Ansible
       + Prometheus
       + Grafana
 
 VM3 → Linux Server 
       + Node Exporter (via Ansible)


##

