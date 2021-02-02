## EC2 Instance Example
This is a simple AWS EC2 instance deployment. We are using the [terraform guide](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) for deploying it. 
This is an overly simplified deployment with just a security group for doing the basic deployment. 

The accompanying  [YouTube Video](https://youtu.be/rCgKZQBvado)

### Background 
The instance will be deployed with `terraform aws_instance` and it will be a basic instance. We also use a security group to allow access for http and ssh, ports 80 and 22. 

We are also getting into the search feature of the `data.aws_ami` to pull an AMI that is basic for AWS Linux 2. 

###### Notice 
If you are going to follow this template for any type of production, please switch it to https instead of just http. This was only done as an example


### The Security Group 
We use the AWS securty group to allow the access. For this example we will have two ingress rules and out egress rule. 
The ingress rule will allow traffic from anywhere over 22 and 80. 

#### Resource 
We start with the `resource "aws_security_group"` 
In the group, we will set the name, a descrition and the VPC ID.
The `name` will be what you will call the group, and these should be unique for you. 

The `description` will be something useful for you to find it later. 

The `vpc_id` will be what VPC it has access to. You should use this if you have multiple VPCs under your account. 

We also have `tags` under the main body, but I like to put them at the bottom because over time the tags can change but the resource will remain the same. 


``` 
resource "aws_securty_group" "my_fancy_security_group" {}
  name =  "ssh-web" 
  description = "SSH and web access"

  tags = {
      "Name" = "Value",
      "More Name" = "Another Value" 
  }
```

##### Ingress 
With the ingress, this will allow the flow of traffic in to item behind this security group, in this example it is the EC2 Instance. 

Under the `ingess` the cidr_blocks control the IP that traffic is coming from. This can set an IP, a range, or a subnet. 
You can group multiple IPs by seperating them with a comma. 

```
cidr_blocks = [
    "10.1.1.0/24".
    "192.168.1.212/32",
    "192.168.2.215/32",
    "172.19.21.20/20"
]
```

The `description` is how you want to lable this rule, or used if this rule is for a one off reason you want to remember later. 

The `from_port` and `to_port` are the ports that this range covers. It allows the traffic from these ports. In general they should be the same or the same ranges. 

Next is the 'protocol' and this can `tcp`, `udp`, `icmp`, `icpmv6` or "-1" which stands for ALL. 

The `security_groups` section is any other included security groups that you wish to include in this securty group section. It is optional. 


```
  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      security_groups  = []
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      security_groups  = []
    },
  ]
```

##### Egress 
The `egress` items are the same as the `ingress` items listed above and they have been copied to reflect that. 

The `cidr_blocks` control the IP that traffic is coming from. This can set an IP, a range, or a subnet. 
You can group multiple IPs by seperating them with a comma. 

```
cidr_blocks = [
    "10.1.1.0/24".
    "192.168.1.212/32",
    "192.168.2.215/32",
    "172.19.21.20/20"
]
```

The `description` is how you want to lable this rule, or used if this rule is for a one off reason you want to remember later. 

The `from_port` and `to_port` are the ports that this range covers. It allows the traffic from these ports. In general they should be the same or the same ranges. 

Next is the 'protocol' and this can `tcp`, `udp`, `icmp`, `icpmv6` or "-1" which stands for ALL. 

The `security_groups` section is any other included security groups that you wish to include in this securty group section. It is optional. 

```
  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      security_groups  = []
     }
  ]
```
### AMI Data 
For this we will be using the Data to call which AMI we want to use for our basic instance we will not be using a lot of the options here. 
We want to select the Amazon Linux 2 machine image.

Instead of `resource` we are going to be using `data` since we are dealing with data and not creating any resources. 

With the data, the layout is simular to the way a resource is utilized. 

```
data "aws_ami" "my_reference" {}
```

We want to select the most recent version of the AMI, so we want to set that flag to true.
```
most_recent = true
```
Next we want to use `filter{}` to narrow down our choices. This is laid out in json. Multiple filter tags are able to be used to help limit the overlapping results. 

You can find other filters by used AWS CLI to describe the AMI or by looking at the AMI in the web console. It is the same filtes you would use with AWS CLI `aws ec2 describe-images --owners self amazon --filter "Name=name, Values=amzn2-ami-hvm-2.0.2021*"`
```
filter {
    name = "Name"
    values = "firstValue"
}

filter {
    name = "Architecture"
    values = ["x86_64"]
}
```
We will have to select an owner for the AMI that is used. This is a required value. 
You can select multiple owners, but there should not be a reason to have multiple ones listed. 

```
owners = ["amazon"]
```

### The EC2 Instance 
This is the part that will deploy a basic EC2 instance, it will not have anything it will only be a basic server, and you will have to manually install everything you want  on it afterwards. 

Again, we are using this to just deploy the instance, there are a lot of other options with this [resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

The resource type will be `aws_instance` 
```
resource "aws_instance" "my_fancy_instance" {}
```
Next is to choose the arguments to use, and since this is a simple deployment it will be straight forward. 

For the `ami` we will use `data.aws_ami` from above, since we have that ID now. 
```
ami = data.aws_ami.my_reference.id
```

With the instance type, you want to choose what you really need for this instance since over provisioning can get expensive quickly. 
If you use this as a module or would like to use it with difference instance types it should be a variable.  
A list of all AWS Instance types can be found [here](https://aws.amazon.com/ec2/pricing/on-demand/)
```
instance_type = var.instance_type
```

Attach the `security_group` from above at this point 
```
security_group = [aws_security_group.my_fancy_security_group.id]
```

For the `key_name` it will use a `key_pair` that you have already provisioned and have access to. If you need to create a new key pair, it is recommended to do it before starting, being sure to downlaod it and set the proper permissions as specified the [Amazon documents](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) 
```
key_name = "my_fancy_keypair"
```

This step is optional if you have a VPN configured or you do not need to access this machine from outside the VPC, but we want to set a public address to this instance so that we can connect to it remotely. 
This is not needed if you are doing an ELB and have your logs going to an S3 bucket or a central logging server. This value can be true or false. 
```
associate_public_ip_address = true 
```

We do need to bind this instance to a subnet, you can hard code it or use other tricks to get the subnet setup on it. In this case, we will use a variable as we did with the VPC ID listed above. 

```
subnet_id = "subnet-XXXXXXXXXX" 
```

Finally here is where the tags are set, since we are using our standard tags, it is a variable, but it can be manually entered. 

```
tags = {
    "Name" = "MyInstance",
    "Location" = "us-west-2" 
}
```

### RAW CODE
Here is the raw code that is also in the [main.tf](main.tf)
```
data "aws_ami" "aws_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.2021*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

resource "aws_security_group" "ec2_instance_sg" {
  name        = "ssh-web"
  description = "SSH and web access GLOBAL!"
  vpc_id      = var.vpc_id

  ingress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 22
      to_port          = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
    },
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 80
      to_port          = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
    },
  ]

  egress = [
    {
      cidr_blocks = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      to_port          = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
    }
  ]

  tags = var.standard_tags
}

resource "aws_instance" "ec2_instance" {
  ami                         = data.aws_ami.aws_linux.id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.ec2_instance_sg.id]
  key_name                    = var.ssh_key_name
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id

  tags = var.standard_tags
}
```

#### My Info 
I can found on my [linktr.ee](https://linktr.ee/hifighetto) and I am always looking at [twitter](https://twitter.com/hifighetto) and [instagram](https://instagram.com/hifighetto)