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

3 - After the user creation, install AWS CLI: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

4 - After AWS CLI installation, run the following command to set up the CLI with your recently created user: 

    aws configure
    And inform the access key id and secret access key. 

Now that you have AWS CLI properly set up, you can run the scripts that will create the infrastructure.

5 - First, we will create the key, in case you want to connect to the ec2 instances
    
    Command executed to create the key
    ./create_key.sh
    
   This command will create a private key named key.pem 

6 - Now lets create our networking resources:

    Command executed to create our network stack
    ./create.sh Hotmart-DevOpsChallenge-VPC network.yml network-parameters.json 

7 - Finally, lets create our servers and ALB:

    Command executed to create our server stack:
    ./create.sh Hotmart-DevOpsChallenge-VPC servers.yml servers.json

To test the solution, go to the console and get the DNS name for your load balancer. The root context / will show a page indicating that you are on the root / context.
The /test context, will show a page indicating that you are on the /test context.


8 - To destroy the solution run:
    
    ./delete.sh Hotmart-DevOpsChallenge-VPC
    ./delete.sh Hotmart-DevOpsChallenge-Servers

Enjoy :)




