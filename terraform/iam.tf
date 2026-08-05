# ==================================================
# EKS Cluster IAM Role
# ==================================================

resource "aws_iam_role" "eks_cluster_role" {

  name = "ecommerce-eks-cluster-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "eks.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ==================================================
# EKS Cluster Policy Attachments
# ==================================================

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {

  role = aws_iam_role.eks_cluster_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_vpc_controller" {

  role = aws_iam_role.eks_cluster_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

# ==================================================
# Worker Node IAM Role
# ==================================================

resource "aws_iam_role" "worker_node_role" {

  name = "ecommerce-worker-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

# ==================================================
# Worker Node Policy Attachments
# ==================================================

resource "aws_iam_role_policy_attachment" "worker_node_policy" {

  role = aws_iam_role.worker_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "ecr_policy" {

  role = aws_iam_role.worker_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly"
}

resource "aws_iam_role_policy_attachment" "cni_policy" {

  role = aws_iam_role.worker_node_role.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
