vpc_name          = "my-vpc"
all_subnet_name   = ["front", "back", "data"]
#all_subnet_cidr   = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
#all_subnet_region = ["us-central1", "us-east1", "us-west1"]

all_subnet_param = {
  "front" = {
    name   = "front"
    cidr   = "192.168.1.0/24"
    region = "us-central1"
  },
  "back" = {
    name   = "back"
    cidr   = "192.168.2.0/24"
    region = "us-east1"
  },
  "data" = {
    name   = "data"
    cidr   = "192.168.3.0/24"
    region = "us-west1"
  }
}

all_route_rules = [
  {
    name              = "egress-to-lab"
    description       = "route to access a fake lab"
    destination_range = "192.168.100.0/24"
    next_hop_ip       = "192.168.1.100"
    tags              = "egress-lab"
    next_hop_internet = "false"
  },
  {
    name              = "egress-to-home"
    description       = "route to access a fake home"
    destination_range = "192.168.200.0/24"
    next_hop_ip       = "192.168.2.100"
    tags              = "egress-home"
    next_hop_internet = "false"
  }
]

all_firewall_rules = [
  {
    name       = "ssh-me"
    desc       = "allow ssh for me"
    protocol   = "tcp"
    ports      = "22"
    source     = "90.15.159.61"
    sourcetags = ""
    targettags = ""
  },
  {
    name       = "ping-me"
    desc       = "allow icmp"
    protocol   = "icmp"
    ports      = ""
    source     = "90.15.159.61"
    sourcetags = ""
    targettags = ""
  }
]

all_computes_1 = {
  "front" = {
    env  = "pr"
    name = "wb"
    ips  = "1" #public ip or not
    type = "small"
    image = "debian"
  },
  "back" = {
    env  = "pr"
    name = "as"
    ips  = "0" 
    type = "small"
    image = "debian"
  },
  "data" = {
    env  = "pr"
    name = "db",
    ips  = "0"
    type = "small"
    image = "debian"
  }
}
