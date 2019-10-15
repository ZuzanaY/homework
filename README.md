# Repository containing requested homework

## Exercise 1. Docker container with python script deployed with ansible logging to host syslog

### prerequisites:
- ubuntu 16.04
- Python 3 
- pip 
- docker
- ansible
- rsyslog
### content:
- rsyslog configuration
- python script
- docker file
- ansible playbooks
### usage hints:
- install ansible server
- configure ansible clients
- run the play ansible_install_docker.yml on the ansible server with extravar rebuild_docker_image=yes as an initial run or when the docker image is intended to be changed and needs to be rebuilt
- run the play ansible_install_docker.yml with extravar rebuild_docker_image=no to spare the time with docker image rebuilt
>> sample: ansible-playbook ansible_install_docker.yml  --extra-vars "rebuild_docker_image=yes"
- run the container on the ansible host to test the result - e.g.:
>> docker run --rm -it  -e API_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -e CITY="Malacky,SK"  --name testubuntu zuzanay/ubuntutest:version1
- check the host syslog for log entries:
>> sudo tail -n 50000 /var/log/syslog | grep humidity

## Exercise 2. Network scanner
### prerequisites: 
- ubuntu 16.04
- nmap
### content:
- bash script
### usage hints:
- call script with ip address or CIDR block 
>>> scanner 1.2.3.4
>>> scanner 1.2.3.0/24

## Exercise 3. Syslog configuration deployed with ansible using ansible roles
### prerequisites:
- ubuntu 16.04
- rsyslog
- ansible
### content:
- ansible role description files
### usage hints:


