resource "kubernetes_service_account" "node" {
  metadata {
    name      = local.daemonset_name
    namespace = var.namespace
  }
  automount_service_account_token = true
}

resource "kubernetes_cluster_role" "node" {
  metadata {
    name = "ebs-csi-node-role"
  }

  rule {
    api_groups = [""]
    resources  = ["nodes"]
    verbs      = ["get"]
  }
}

resource "kubernetes_cluster_role_binding" "node" {
  metadata {
    name = "ebs-csi-provisioner-binding"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.node.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.node.metadata[0].name
    namespace = kubernetes_service_account.node.metadata[0].namespace
  }
}