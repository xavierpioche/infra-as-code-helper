vpc_name = "my-vpc"
all_subnet_name = [ "front" , "back" , "data" ]
all_subnet_cidr = [ "192.168.1.0/24" , "192.168.2.0/24" , "192.168.3.0/24" ]
all_subnet_region = [ "us-central1" , "us-east1" , "us-west1" ]

all_route_rules = [
        {
            name                   = "egress-to-lab"
            description            = "route to access a fake lab"
            destination_range      = "192.168.100.0/24"
            next_hop_ip            = "192.168.1.100"
            tags                   = "egress-lab"
            next_hop_internet      = "false"
        }
]

all_firewall_rules = [
        {
            name       =    "ssh-me"
            desc       =    "allow ssh for me"
            protocol   =    "tcp"
            ports      =    "22"
            source     =    "90.15.159.61"
            sourcetags =    ""
            targettags =    ""
        } ,
        {
            name       =    "ping-me"
            desc       =    "allow icmp"
            protocol   =    "icmp"
            ports      =    ""
            source     =    "90.15.159.61"
            sourcetags =    ""
            targettags =    ""
        } 
]
