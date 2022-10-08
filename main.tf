module "infrastructure" {
  source = "./Infrastructure"
}

module "github_repo" {
  source = "./Repository"
}
