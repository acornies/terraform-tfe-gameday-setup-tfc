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
  name         = var.event_name
  organization = data.tfe_organization.event.name
}

resource "tfe_team" "participant" {
  name       = var.team_name
  visibility = "secret"
  organization_access {}
}

resource "tfe_workspace" "challenge" {
  name       = var.workspace_name
  tag_names  = ["${var.event_name}"]
  project_id = data.tfe_project.event.id
}

# Add team admin access to workspace
resource "tfe_team_access" "challenge" {
  access       = "admin"
  team_id      = tfe_team.participant.id
  workspace_id = tfe_workspace.challenge.id
}

# Create a TFC team token per team
resource "tfe_team_token" "participant" {
  team_id = tfe_team.participant.id
}