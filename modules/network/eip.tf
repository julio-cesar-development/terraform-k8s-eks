resource "aws_eip" "main-eip" {
  vpc = true

  tags = {
    Name = format("%s-main-eip", var.cluster_name)
  }
}
