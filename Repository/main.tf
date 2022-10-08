provider "github" {
  token = local.github-token
}

locals {
  github-email    = "tbincan@gmail.com"    # you need to change this line
  github-username = "T1kcan"               # you need to change this line
  github-token    = file("github_token.txt") # you need to change this line
}

resource "github_repository" "githubrepo" {
  name       = "Final_Project"
  visibility = "public"
  auto_init  = true
}

output "github-url" {
  value = github_repository.githubrepo.http_clone_url
}

output "github-svn-url" {
  value = github_repository.githubrepo.svn_url
}