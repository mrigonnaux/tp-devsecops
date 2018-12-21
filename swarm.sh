#!/bin/sh



ssh root@10.13.9.175 'docker swarm init'



swarmWorker=$(ssh root@10.13.9.175 'docker swarm join-token worker')



worker=$(echo $swarmWorker | awk '{print $12 " " $13 " " $14 " " $15 " " $16 " " $17}')



swarmManager=$(ssh root@10.13.9.175 'docker swarm join-token manager')



manager=$(echo $swarmManager | awk '{print $12 " " $13 " " $14 " " $15 " " $16 " " $17}')



ssh root@10.13.9.176 '$manager'

ssh root@10.13.9.177 '$manager'

ssh root@10.13.9.178 '$worker'

ssh root@10.13.9.179 '$worker'
