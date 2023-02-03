# tf-docker

Plan- Create managed nodes for Ansible and use the host device as control node to perform tasks on the managed nodes

What tf does:
* Create containers from a list of names
* Output the logs
* Store the IPs in hosts file for ansible to use

Result: Turns out Mac does not support running containers in the host network. So cannot use it as a control node
