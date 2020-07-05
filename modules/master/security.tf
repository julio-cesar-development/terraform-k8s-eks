resource "aws_security_group" "cluster-master-sg" {
  name   = format("%s-cluster-master-sg", var.cluster_name)
  vpc_id = var.cluster_vpc.id

  # Outbound
  egress {
    from_port = 0
    to_port   = 0
    # TCP/UDP
    protocol = "-1"
    # all interfaces
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = format("%s-cluster-master-sg", var.cluster_name)
  }
}

resource "aws_security_group_rule" "cluster-master-rule-ingress-http" {
  # Inbound
  from_port = 80
  to_port   = 80
  # TCP only
  protocol = "tcp"
  # all interfaces
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.cluster-master-sg.id

  type = "ingress"
}

resource "aws_security_group_rule" "cluster-master-rule-ingress-https" {
  # Inbound
  from_port = 443
  to_port   = 443
  # TCP only
  protocol = "tcp"
  # all interfaces
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.cluster-master-sg.id

  type = "ingress"
}
