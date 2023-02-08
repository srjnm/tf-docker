# tf-docker

Plan- Create managed nodes for Ansible and use the host device as control node to perform tasks on the managed nodes

What tf does:
* Create containers from a list of names
* Output the logs
* Store the IPs in hosts file for ansible to use

Result: Turns out Mac does not support that. So cannot use it as a control node
------------------------------------------------------------------------------------------
Fix: Creating the whole ansible architecture within a docker network

What tf does now:
* Create a bridge network for the containers
* Create control node
* Create managed nodes from a list of names
* Create the ansible hosts file
