
variable "repo_url" {
  description = "Git repository URL containing Kubernetes manifests"
  type        = string
}

variable "namespace" {
  description = "Namespace for deploying SaaSgenix application"
  type        = string
  default     = "saasgenix"
}

variable "sync_policy" {
  description = "ArgoCD sync policy (e.g., automated or manual)"
  type        = string
  default     = "automated"
}

resource "kubectl_manifest" "argocd_install" {
  yaml_body = file("https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml")
}

resource "kubernetes_namespace" "saasgenix" {
  metadata {
    name = var.namespace
  }
}

resource "kubectl_manifest" "saasgenix_app" {
  yaml_body = templatefile("${path.module}/argocd_saasgenix_app.yaml.tpl", {
    repo_url   = var.repo_url,
    namespace  = var.namespace,
    sync_policy = var.sync_policy
  })
}
