variable "civo_token" {
  type        = string
  default     = ""
  description = "description"
}

## Flux configuration

variable "flux_github_token" {
  sensitive = true
  type      = string
}