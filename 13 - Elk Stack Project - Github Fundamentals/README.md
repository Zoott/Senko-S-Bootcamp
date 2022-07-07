## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

[ELK Network Diagram](https://github.com/Zoott/Senko-S-Bootcamp/blob/master/13%20-%20Elk%20Stack%20Project%20-%20Github%20Fundamentals/Images/NetworkDiagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the playbook file may be used to install only certain pieces of it, such as Filebeat.

  - [ELK Install Playbook](https://github.com/Zoott/Senko-S-Bootcamp/blob/master/13%20-%20Elk%20Stack%20Project%20-%20Github%20Fundamentals/Playbooks/install-elk.yml)
  - [Filebeat Playbook](https://github.com/Zoott/Senko-S-Bootcamp/blob/master/13%20-%20Elk%20Stack%20Project%20-%20Github%20Fundamentals/Playbooks/filebeat-playbook.yml)
  - [Metricbeat Playbook](https://github.com/Zoott/Senko-S-Bootcamp/blob/master/13%20-%20Elk%20Stack%20Project%20-%20Github%20Fundamentals/Playbooks/metricbeat-playbook.yml)

Other playbook files can be found in the 'Playbooks' directory on GitHub.

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting access to the network.
- Load balancers ensure that the application on the web servers is available by by distributing and rerouting traffic to available servers in case a server (or multiple) goes down. The main advantage of a Jump Box is that it acts as a gateway to all of the other servers. To do any administrative tasks, administrators have to log on to the Jump Box before doing any work on the other servers. 

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system traffic.
- Filebeat watches for changes to the log files/locations we specify, collects log events, and sends them to elasticsearch/logstash.
- Metricbeat records metrics from the operating system and from services running on the server.

The configuration details of each machine may be found below.

| Name                 | Function   | IP Address | Operating System |
|----------------------|------------|------------|------------------|
| Jump-Box-Provisioner | Gateway    | 10.0.0.4   | Linux Ubuntu     |
| Web-1                | Web Server | 10.0.0.5   | Linux Ubuntu     |
| Web-2                | Web Server | 10.0.0.6   | Linux Ubuntu     |
| Web-3                | Web Server | 10.0.0.7   | Linux Ubuntu     |
| ElkServer            | ELK Stack  | 10.1.0.4   | Linux Ubuntu     |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the administrator's workstation's public IP address.

Machines within the network can only be accessed by the Jump Box.
- Only the Jump Box machine can access the ElkServer VM using SSH. The Jump Box machine's IP is 10.0.0.4

A summary of the access policies in place can be found in the table below.

| Name                 | Publicly Accessible              | Allowed IP Addresses                            |
|----------------------|----------------------------------|-------------------------------------------------|
| Jump-Box-Provisioner | Yes (SSH)                        | Administrator's workstation's Public IP (AW_IP) |
| Web-1                | Yes (via Load Balancer, HTTP:80) | AW_IP + 10.0.0.4 (Jump Box)                     |
| Web-2                | Yes (via Load Balancer, HTTP:80) | AW_IP + 10.0.0.4 (Jump Box)                     |
| Web-3                | Yes (via Load Balancer, HTTP:80) | AW_IP + 10.0.0.4 (Jump Box)                     |
| ElkServer            | Yes (HTTP:5601)                  | AW_IP + 10.0.0.4 (Jump Box)                     |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because...
- It automates away the time consuming and tedious tasks which leaves less room for error and ultimately makes the work easier and consistent.

The playbook implements the following tasks:
- Install Docker
- Install Python
- Install Docker's Python Module
- Increase memory and virtual memory to support the ELK Stack
- Download and lauch the ELK container.

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

[docker ps screenshot](https://github.com/Zoott/Senko-S-Bootcamp/blob/master/13%20-%20Elk%20Stack%20Project%20-%20Github%20Fundamentals/Images/docker_ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- Web-1: 10.0.0.5
- Web-2: 10.0.0.6
- Web-3: 10.0.0.7

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat will collect logs/any changes made.
- Metricbeat will collect the metrics.

### Using the Playbook
In order to use the playbook, we will need to have an Ansible control node already configured. Assuming we have such a control node provisioned: 

We SSH into the control node and follow the steps below:
- Copy the playbook files to Ansible Docker Container (or make them in Ansible Container).
- Update the hosts file to include:

   [webservers]
   10.0.0.5 ansible_python_interpreter=/usr/bin/python3
   10.0.0.6 ansible_python_interpreter=/usr/bin/python3
   10.0.0.7 ansible_python_interpreter=/usr/bin/python3

   [elkservers]
   10.1.0.4 ansible_python_interpreter=/usr/bin/python3

- Also update ansible.cfg to set the remote_user parameter since all of our VM's in this project use the same username.
- We run the playbooks, and navigate to http://20.37.38.87/setup.php (For Web Servers with DVWA containers) or http://20.58.191.189:5601 (for ElkServer) to check that the installation worked as expected.

- Example of a playbook file is install-elk.yml
- To run playbooks on specific machines, we will update the hosts file with groups of machines with which we operate. To run the playbook on a specific group we will edit the playbook file to specify which hosts group will be affected. For example:

```
---
- name: Config Web VM with Docker
  hosts: elk
  become: true
  tasks:
```
This will run the playbook on the elk group.

```
---
- name: Config Elk VM with Docker
  hosts: webservers
  become: true
  tasks:
```
This will run the playbook on the webservers group.

- To check if the ELK Stack is running properly we visit the following url:

 - http://[ElkServer_Public_IP]:5601


As a bonus I have provided some of the commands used in this project:

- ssh RedAdmin@[Jump_Box_Public_IP] - to connect to the Jump Box machine.
- sudo docker ps -a  - to list the installed containers
- sudo docker start [container_name] - to start the specific container
- sudo docker attach [container_name] - to attach to the said container
- ansible webservers -m command -a "command"  - to run a command on all machines in the webservers group at the same time
- ansible-playbook [playbook_name].yml - to run a playbook
