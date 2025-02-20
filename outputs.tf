output "ebs_csi_driver_name" {
  description = "The Name of the EBS CSI driver"
  value       = kubernetes_csi_driver_v1.ebs.metadata[0].name
}

output "ebs_csi_driver_controller_role_arn" {
  description = "The Name of the EBS CSI driver controller IAM role ARN"
  value       = module.ebs_controller_role.iam_role_arn
}

output "ebs_csi_driver_controller_role_name" {
  description = "The Name of the EBS CSI driver controller IAM role name"
  value       = module.ebs_controller_role.iam_role_name
}

output "ebs_csi_driver_controller_role_policy_arn" {
  description = "The Name of the EBS CSI driver controller IAM role policy ARN"
  value       = aws_iam_policy.ebs_controller_policy.arn
}

output "ebs_csi_driver_controller_role_policy_name" {
  description = "The Name of the EBS CSI driver controller IAM role policy name"
  value       = aws_iam_policy.ebs_controller_policy.name
}

output "wait_for_it" {
  description = "value"
  value = sha1(join("-", [
    kubernetes_cluster_role.attacher.metadata[0].uid,
    kubernetes_cluster_role.node.metadata[0].uid,
    kubernetes_cluster_role.provisioner.metadata[0].uid,
    var.enable_volume_resizing ? kubernetes_cluster_role.resizer[0].metadata[0].uid : "no",
    var.enable_volume_snapshot ? kubernetes_cluster_role.snapshotter[0].metadata[0].uid : "no",
    kubernetes_cluster_role_binding.attacher.metadata[0].uid,
    kubernetes_cluster_role_binding.node.metadata[0].uid,
    kubernetes_cluster_role_binding.provisioner.metadata[0].uid,
    var.enable_volume_resizing ? kubernetes_cluster_role_binding.resizer[0].metadata[0].uid : "no",
    var.enable_volume_snapshot ? kubernetes_cluster_role_binding.snapshotter[0].metadata[0].uid : "no",
    kubernetes_csi_driver_v1.ebs.metadata[0].uid,
    kubernetes_daemonset.node.metadata[0].uid,
    kubernetes_deployment.ebs_csi_controller.metadata[0].uid,
  ]))
}
