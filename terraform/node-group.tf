resource "aws_eks_node_group" "main" {

  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "ecommerce-node-group"
  node_role_arn   = aws_iam_role.worker_node_role.arn

  subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id
  ]

  instance_types = ["t3.medium"]

  capacity_type = "ON_DEMAND"

  scaling_config {

    desired_size = 2
    max_size     = 2
    min_size     = 2

  }

  update_config {

    max_unavailable = 1

  }

  labels = {

    Environment = "dev"

  }

  tags = {

    Name = "ecommerce-node-group"

  }

  depends_on = [

    aws_iam_role_policy_attachment.worker_node_policy,
    aws_iam_role_policy_attachment.cni_policy,
    aws_iam_role_policy_attachment.ecr_policy,
    aws_eks_cluster.main

  ]

}
