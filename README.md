# Census RH Toolbox

This project contains RabbitMQ utilities for RH support.

## How to use - Message Manipulator

View topmost messages on a queue (default 100 max):
   `queuetool <queue name>`

View specific number of messages at the head of a queue:
   `queuetool <queue name> -l <limit>`
   
Search for message(s) on a queue by their content:
   `queuetool <queue name> -s <search text>`
     
Search specific number of topmost messages(s) on a queue by their content:
   `queuetool <queue name> -s <search text> -l <limit>`
     
View a message based on it's hashcode:
   `queuetool <queue name> <message hash> VIEW`
   
Delete message from a queue:
   `queuetool <queue name> <message hash> DELETE`
   
Move message from one queue to another:
   `queuetool <queue name> <message hash> MOVE <destination queue>`
   
If you don't want to use the 'queuetool' alias the commands can be run directly by substituting
'python queue_manipulator.py'
   

## How to see key queue statistics

To see key information about each queue:
   `python poison_message_queue_finder.py`

This will list information such as queue depth and the current processing rate. Note that the
numbers for the publish_rate and ack_rate have a delay of several seconds.

The 'consumer_count' can be used to spot 'zombie' processes. If the consuming process has suffered a Rabbit 
problem and appears to be working, but is not actually consuming messages, then the key indicator is that
the 'consumer_count' will be '0'.


## Running in Kubernetes
To run the toolbox in a kubernetes environment, you'll have to create the deployment using `census-rm-toolbox-deployment.yml`
```bash
make apply-deployment
```
Once the pod is up, you can connect to it:
```bash
make connect-to-pod
```
Once you're finished with the pod, you can remove it from your kubernetes environment:
```bash
make delete-pod


## Running against a local Rabbit
To run on a developer's machine with a local Rabbit the following environment variables
need to be set before running :

```
$ export RABBITMQ_HTTP_PORT=46672
$ export RABBITMQ_SERVICE_PORT=35672
```
