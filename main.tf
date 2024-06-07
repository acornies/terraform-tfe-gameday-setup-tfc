terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.55.0"
    }
  }
}

data "tfe_organization" "event" {}

data "tfe_project" "event" {
  name         = var.hcp_terraform_project
  organization = data.tfe_organization.event.name
}

resource "tfe_team" "participants" {
  for_each     = var.participants
  organization = data.tfe_organization.event.name
  name         = each.value.team
  visibility   = "secret"
  organization_access {}
}

resource "tfe_workspace" "challenges" {
  for_each     = var.participants
  name         = each.key
  organization = data.tfe_organization.event.name
  tag_names    = ["${var.event_name}"]
  project_id   = data.tfe_project.event.id
}

# Add team admin access to workspace
resource "tfe_team_access" "challenges" {
  for_each     = var.participants
  access       = "admin"
  team_id      = tfe_team.participants[each.key].id
  workspace_id = tfe_workspace.challenges[each.key].id
}

# Add the team caption email to the TFC organization
# resource "tfe_organization_membership" "participants" {
#   for_each     = var.participants
#   organization = data.tfe_organization.event_org.name
#   email        = each.value.email
# }

# Create a TFC team token per team
resource "tfe_team_token" "participants" {
  for_each = var.participants
  team_id  = tfe_team.participants[each.key].id
}