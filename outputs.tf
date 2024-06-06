output "workspace" {
  value = tfe_workspace.challenge.name
}

output "team_token" {
  value = tfe_team_token.participant.token
}