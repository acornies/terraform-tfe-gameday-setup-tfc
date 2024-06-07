output "workspaces" {
  value = {
    for key, value in var.participants : key => tfe_workspace.challenges[key].name
  }
}

output "team_tokens" {
  value = {
    for key, value in var.participants : key => tfe_team_token.participants[key].token
  }
}