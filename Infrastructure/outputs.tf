# //////////////////////////////
# OUTPUT
# //////////////////////////////
output "Ansible_instance_dns" {
  value = aws_eip.EIP.public_dns
}
output "Ansible_instance_pub_ip" {
  value = aws_eip.EIP.public_ip
}
# output "Ansible_instance_apub_ip" {
#   value = aws_eip.EIP.public_ip
# }
output "Jenkins_instance-dns" {
  value = aws_eip.eip_manager[0].public_dns
  #aws_instance.type-2[0].public_dns
}
output "Jenkins_instance-pub_ip2" {
  value = aws_eip.eip_manager[0].public_ip
}
# output "Jenkins_instance-apub_ip2" {
#   value = aws_instance.type-2[0].associate_public_ip_address
# }
output "Kubernetes_instance-dns" {
  value = aws_eip.eip_manager[1].public_dns
}
output "Kubernetes_instance-pub_ip2" {
  value = aws_eip.eip_manager[1].public_ip
}
# output "Kubernetes_instance-apub_ip2" {
#   value = aws_instance.type-2[1].associate_public_ip_address
# }
# ssh -i "ssh-key.pem" ec2-user@ec2-34-196-60-115.compute-1.amazonaws.com