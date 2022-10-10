provider "github" {
  token = local.github-token
}

locals {
  github-email    = "" # you need to change this line
  github-username = "" # you need to change this line
  github-token    = "" # you need to change this line
}

resource "github_repository" "githubrepo" {
  name       = "Final_Project_2022"
  visibility = "public"
  auto_init  = true
}

output "github-url" {
  value = github_repository.githubrepo.http_clone_url
}

output "github-svn-url" {
  value = github_repository.githubrepo.svn_url
}