variable "vpc_ipam_pools" {
  description = <<EOT
Map of vpc_ipam_pools, attributes below
Required:
    - address_family
    - ipam_scope_id
Optional:
    - allocation_default_netmask_length
    - allocation_max_netmask_length
    - allocation_min_netmask_length
    - allocation_resource_tags
    - auto_import
    - aws_service
    - cascade
    - description
    - locale
    - public_ip_source
    - publicly_advertisable
    - region
    - source_ipam_pool_id
    - tags
    - tags_all
    - source_resource (block):
        - resource_id (required)
        - resource_owner (required)
        - resource_region (required)
        - resource_type (required)
EOT

  type = map(object({
    address_family                    = string
    ipam_scope_id                     = string
    source_ipam_pool_id               = optional(string)
    region                            = optional(string)
    publicly_advertisable             = optional(bool)
    public_ip_source                  = optional(string)
    locale                            = optional(string)
    description                       = optional(string)
    cascade                           = optional(bool)
    aws_service                       = optional(string)
    auto_import                       = optional(bool)
    allocation_resource_tags          = optional(map(string))
    allocation_min_netmask_length     = optional(number)
    allocation_max_netmask_length     = optional(number)
    allocation_default_netmask_length = optional(number)
    tags                              = optional(map(string))
    tags_all                          = optional(map(string))
    source_resource = optional(object({
      resource_id     = string
      resource_owner  = string
      resource_region = string
      resource_type   = string
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.vpc_ipam_pools : (
        v.allocation_default_netmask_length == null || (v.allocation_default_netmask_length >= 0 && v.allocation_default_netmask_length <= 128)
      )
    ])
    error_message = "must be between 0 and 128"
  }
  validation {
    condition = alltrue([
      for k, v in var.vpc_ipam_pools : (
        v.allocation_max_netmask_length == null || (v.allocation_max_netmask_length >= 0 && v.allocation_max_netmask_length <= 128)
      )
    ])
    error_message = "must be between 0 and 128"
  }
  validation {
    condition = alltrue([
      for k, v in var.vpc_ipam_pools : (
        v.allocation_min_netmask_length == null || (v.allocation_min_netmask_length >= 0 && v.allocation_min_netmask_length <= 128)
      )
    ])
    error_message = "must be between 0 and 128"
  }
  # Note: 6 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

