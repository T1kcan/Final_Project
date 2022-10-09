# //////////////////////////////
# OUTPUT
# //////////////////////////////
output "Ansible_instance_dns" {
  value = module.infrastructure.Ansible_instance_dns
}
output "Ansible_instance_pub_ip" {
  value = module.infrastructure.Ansible_instance_pub_ip
}
output "Jenkins_instance-dns" {
  value = module.infrastructure.Jenkins_instance-dns
}
output "Jenkins_instance-pub_ip2" {
  value = module.infrastructure.Jenkins_instance-pub_ip2
}
output "Kubernetes_instance-dns" {
  value = module.infrastructure.Kubernetes_instance-dns
}
output "Kubernetes_instance-pub_ip2" {
  value = module.infrastructure.Kubernetes_instance-pub_ip2
}
output "Github_Repository_SVN" {
  value = module.github_repo.github-svn-url
}
output "Github_Repository_URL" {
  value = module.github_repo.github-url
}
output "ansible_connection" {
  value = "ssh -i ssh-key.pem ec2-user@${module.infrastructure.Ansible_instance-pub_ip2}"
}
