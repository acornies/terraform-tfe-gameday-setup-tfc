variable "event_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.event_name))
    error_message = "Event name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "workspace_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.workspace_name))
    error_message = "Workspace name must only contain alphanumeric characters, dashes, and underscores."
  }
}

variable "team_name" {
  type = string
  validation {
    condition     = can(regex("^[-a-zA-Z0-9_]+$", var.team_name))
    error_message = "Team name must only contain alphanumeric characters, dashes, and underscores."
  }
}