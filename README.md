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
## 🔧 Preparing the Linux VMs Environment

Before configuring Ansible, each Linux VM is joined to the Active Directory domain.
This step is critical for several reasons:

- Centralized identity management:
  Joining the Linux nodes to the domain allows all authentication to be handled by Active Directory. This gives the environment the same level of identity governance used in real enterprise infrastructures.

- Consistent hostname resolution:
  Once the Linux VMs become domain members, every node is automatically registered in the domain DNS. This allows Ansible to communicate with the servers using their hostnames instead of IPs, which is far more   stable and scalable.

- Unified access control:
  By joining to AD, we can apply domain-level policies to Linux machines (sudo mappings, SSH access rules, service accounts), ensuring the same access standards across Windows and Linux.

- Better maintainability & clean inventory:
  Ansible’s inventory becomes clean and simple: only server names—no IPs, no hard-coded credentials.
  
Example:
```
[linux_nodes]
node1
node2
```
This approach mirrors how large organizations manage hybrid Linux/Windows fleets, ensuring reliability, security, and easier long-term automation.

### 🔹 Preparing Linux Server for Domain Join (Offline Environment)

Before joining the Linux server to the Active Directory domain, the system must have several required packages installed (such as **realmd, sssd, adcli, samba, krb5, chrony**, etc.).
These packages are necessary for Kerberos authentication, SSSD communication, and the domain join process.

But in our case, the server is **offline** and cannot reach the internet — so **dnf** has no source to download these packages from.

Because of this, we need to create a **Local Repository**.

Since the OS was installed from an **ISO image**, this ISO already contains all the packages that the server may need.
So the solution is:

1. **Mount the ISO** (the same ISO used during OS installation)
2. **Create a Local Repository file** that points to the mounted ISO
3. This way, when the server needs any package, **dnf will search inside the local ISO repository instead of the internet**

In short:

> The server is offline → dnf has no external repos
> We mount the OS ISO → all required packages are inside it
> We create a Local Repo pointing to the mounted ISO
> Now dnf can install all packages needed for the Domain Join process



