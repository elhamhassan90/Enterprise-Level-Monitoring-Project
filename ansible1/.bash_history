ssh-keygen -t rsa -b 4096
nano /etc/hosts 
sudo nano /etc/hosts 
clear
ssh-copy-id ansible1@node1  
ssh-copy-id ansible1@prom-graf  
clear
sudo nano /etc/ansible/hosts
ansible node1 -m ping
clear
sudo apt install python3-pip -y
sudo yum install python3-pip -y
su - root
sudo yum install python3-pip -y
ls /mnt/hgfs/
sudo ls /mnt/hgfs/
exit
cd /tmp/pywinrm_offline/
pip install --user --no-index --find-links=. pywinrm   #--no-index option tells pip to avoid looking online, and --find-links= points to the local folder containing the packages.
clear
pip install --user --no-index --find-links=. pywinrm
yum install pip 
sudo yum install pip 
clear
pip install --user --no-index --find-links=. pywinrm
sudo dnf install python3-pip --disablerepo="*" --enablerepo=baseos --enablerepo=appstream -y
yum repolist 
sudo dnf install python3-pip 
sudo yum install python3-pip 
clear
python3 -m ensurepip
python3 -m pip install --upgrade pip
pip install --user --no-index --find-links=. pywinrm
pip3 --version
pip3 install --user --no-index --find-links=. pywinrm
pip3 show winrm | grep Version
pip3 show pywinrm | grep Version
exit
ls 
cd windows-servers/
ls
pwd
ls
cd ..
ls 
rm windows-server
ls
rm -rfwindows-server
rm -rf windows-server
ls
clear
cd windows-servers/
ls
nano setup-we.yaml 
sudo nano setup-we.yaml 
clear
nano  inventory.ini 
ansible-playbook setup-we.yaml --ask-vault-password
pwd
nano setup-we.yaml 
sudo nano setup-we.yaml 
ansible-playbook setup-we.yaml --ask-vault-password
pwd
sudo nano setup-we.yaml 
ansible-playbook setup-we.yaml --ask-vault-password
ls 
cd ../
ls 
cd node-exporter/
ls
rm elham-setup-ne.yaml 
sudo rm elham-setup-ne.yaml 
ls
nano node-script.sh 
nano setup-ne.yaml 
sudo nano setup-ne.yaml 
ansible-playbook setup-ne.yaml --ask-vault-password
nano node-script.sh 
sudo nano setup-ne.yaml 
ansible-playbook setup-ne.yaml --ask-vault-password
ls 
nano setup-ne.yaml 
nano node-script.sh 
eyo@
