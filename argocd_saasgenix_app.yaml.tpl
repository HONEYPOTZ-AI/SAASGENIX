
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: saasgenix
  namespace: argocd
spec:
  project: default
  source:
    repoURL: "${repo_url}"
    targetRevision: HEAD
    path: .
  destination:
    server: https://kubernetes.default.svc
    namespace: ${namespace}
  syncPolicy:
%{ if sync_policy == "automated" }
    automated:
      prune: true
      selfHeal: true
%{ endif }
