## shellmcast-nclu

### Summary:

This is an Ansible demo which configures the described topology Shellmcast repo

### Network Diagram:

![Network Diagram](https://github.com/Cloudofyou/shellmcast-nclu/blob/master/documentation/shellmcast.png)

## Ignore everything below this!! 

### Initializing the demo environment:

First, make sure that the following is currently running on your machine:

1. Vagrant > version 2.1.5

    https://www.vagrantup.com/

2. Virtualbox > version 5.2.16

    https://www.virtualbox.org

3. Copy the Git repo to your local machine:

    ```git clone https://github.com/Cloudofyou/poc-oneok```

4. Change directories to the following

    ```cd poc-oneok```

6. Run the following:

    ```./bringitup.sh```
    
### Running the Ansible Playbook

1. SSH into the oob-mgmt-server:

    ```cd vx-simulation```
    ```vagrant ssh oob-mgmt-server```

2. Copy the Git repo unto the oob-mgmt-server:

    ```git clone https://github.com/Cloudofyou/poc-oneok```

3. Change directories to the following

    ```poc-oneok/automation```

### Temporary work arounds until automation is fixed

1. SSH into all 4 of the servers with:

   ```ssh server01```
   
   ```ssh server02```
   
   ```ssh storage01```
   
   ```ssh storage02```
   
2. Enter the password on each server:

   ```CumulusLinux!```
   
3. Download and install traceroute:

   ```sudo apt-get install traceroute```
   
   ```exit```

4. Run the following the poc-oneok/automation directory:

    ```./provision.sh```

This will run the automation script and configure the environment.

5. Fix the servers routing table on all 4 servers:

    ```sudo ip route delete default```
    
    --On storage01 and storage02 use:
    
    ```sudo ip route add default via 10.18.10.1```
    
    --On server01 and server02 use:
    
    ```sudo ip route add default via 10.1.212.1```

### Errata

### Temp

```ansible servers -a `wget -O /home/cumulus/.ssh/authorized_keys "http://192.168.200.254/authorized_keys"` ```

```ansible storage -a `wget -O /home/cumulus/.ssh/authorized_keys "http://192.168.200.254/authorized_keys"` ```

```ansible servers -a "sudo ip route delete default" ```

```ansible storage -a "sudo ip route delete default" ```

```ansible servers -a "sudo ip route add default via 10.1.212.1" ```

```ansible storage -a "sudo ip route add default via 10.18.10.1" ```


1. To shutdown the demo, run the following command from the vx-simulation directory:

    ```vagrant destroy -f```

2. This topology was configured using the Cumulus Topology Converter found at the following URL:

    https://github.com/CumulusNetworks/topology_converter

3. The following command was used to run the Topology Converter within the vx-simulation directory:

    ```python2 topology_converter.py poc-oneok.dot -c```

    After the above command is executed, the following configuration changes are necessary:

4. Within ```vx-simulation/helper_scripts/auto_mgmt_network/OOB_Server_Config_auto_mgmt.sh```

The following stanza:

    #Install Automation Tools
    puppet=0
    ansible=1
    ansible_version=2.3.1.0

Will be replaced with the following:

    #Install Automation Tools
    puppet=0
    ansible=1
    ansible_version=2.6.2

The following stanza will replace the install_ansible function:

```
install_ansible(){
echo " ### Installing Ansible... ###"
apt-get install -qy ansible sshpass libssh-dev python-dev libssl-dev libffi-dev
sudo pip install pip --upgrade
sudo pip install setuptools --upgrade
sudo pip install ansible==$ansible_version --upgrade
}
```

Add the following ```echo``` right before the end of the file.

    echo " ### Adding .bash_profile to auto login as cumulus user"
    echo "sudo su - cumulus" >> /home/vagrant/.bash_profile
    echo "exit" >> /home/vagrant/.bash_profile

    echo "############################################"
    echo "      DONE!"
    echo "############################################"
