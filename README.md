#### IT WILL ONLY WORK IF YOU RUN THIS SOLUTION FROM A LINUX MACHINE ####

This solution will launch Ec2 instances with the Nginx web server running into Docker containers on AWS in Oregon Region programmatically.
We will execute 3 commands, one responsible for ssh key creation, another for networking creation, and the last one for servers and ALB creation.

We will use the following AWS resources:

CloudFormation, AutoScaling, EC2, VPC, Security Groups, NAT Gateway, Internet Gateway, ALB, AWS CLI, and CloudWatch.

The load balancer will route traffic between two autoscaling groups, one on root context / and another one on /test

The auto-scaling policy is high CPU consumption

The diagram explaining this Infrastructure is in this folder in pdf format. 

The dockerfiles used to create the containers is in the Dockerfile_RootContext and Dockerfile_TestContext.

To run this solution in your own AWS account:

1 - Clone this repository to you linux machine.
    
    git clone https://github.com/luizmiguelsl/Hotmart-DevOpsChallenge

2 - On AWS console, you need to create a user on IAM with Programmatic access and attach the AdministratorAccess policy to it. 
    Don't forget to save the Access key ID and the Secret Access Key.

3 - On AWS console, you need to create a key pair named hotmart-key on Oregon region, and save the private key file. This key will be used to access the servers created.

4 - After the user creation, install AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

5 - After AWS CLI installation, run the following command to set up the CLI with your recently created user: 

    aws configure
    And inform the access key id and secret access key. 

Now that you have AWS CLI properly set up, you can run the scripts that will create the infrastructure.

Important: Give to the scripts downloaded execution permission:
    
    chmod u+x ./create.sh
    chmod u+x ./delete.sh
    chmod u+x ./update.sh

6 - Now lets create our networking resources:

    Command executed to create our network stack
    ./create.sh Hotmart-DevOpsChallenge-VPC network.yml network-parameters.json 

7 - Finally, let's create our servers and ALB, but make sure that the network stack has finished the creation

    Command executed to create our server stack:
    ./create.sh Hotmart-DevOpsChallenge-Servers servers.yml servers-parameters.json

To test the solution, go to the console and get the DNS name for your load balancer. The root context / will show a page indicating that you are on the root / context.
The /test context will show a page indicating that you are on the /test context.
If you refresh the page a couple of times, you'll see that the container id keeps changing, showing that the load balancer is working properly.


8 - To destroy the solution run:
    
    ./delete.sh Hotmart-DevOpsChallenge-Servers

    Wait until the Servers stack is done deleting everything and run:
    ./delete.sh Hotmart-DevOpsChallenge-VPC

Optional - If you want to change something into the YAML files after the stack is already created, just run the update.sh script:

    To update the network stack
    ./update.sh Hotmart-DevOpsChallenge-VPC network.yml network-parameters.json 

    To update the servers stack
    ./update.sh Hotmart-DevOpsChallenge-Servers servers.yml servers-parameters.json


Improvment Points:

1 - Although we created a keypair, we didn't implement a bastion host to connect to the instances.

2 - We can validate if the aws cli is installed and properly set up before running the scrips create.sh, delete.sh and update.sh

3 - We can add to the YAML files a way to create the keypair and save the private key programmatically


Enjoy :)




