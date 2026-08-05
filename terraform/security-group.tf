resource "aws_security_group" "eks_cluster_sg" {

  name        = "eks-cluster-sg"
  description = "Security Group for EKS Cluster"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "HTTPS"

    from_port = 443
    to_port   = 443
    protocol  = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "eks-cluster-sg"
  }
}

resource "aws_security_group" "worker_node_sg" {

  name   = "worker-node-sg"
  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 0
    to_port   = 65535

    protocol = "tcp"

    self = true
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "worker-node-sg"
  }
}

resource "aws_security_group" "ssh_sg" {

  name   = "ssh-sg"
  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 22
    to_port   = 22

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {

    from_port = 0
    to_port   = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  tags = {
    Name = "ssh-sg"
  }
}
