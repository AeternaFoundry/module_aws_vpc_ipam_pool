resource "aws_vpc_ipam_pool" "vpc_ipam_pools" {
  for_each = var.vpc_ipam_pools

  address_family                    = each.value.address_family
  ipam_scope_id                     = each.value.ipam_scope_id
  source_ipam_pool_id               = each.value.source_ipam_pool_id
  region                            = each.value.region
  publicly_advertisable             = each.value.publicly_advertisable
  public_ip_source                  = each.value.public_ip_source
  locale                            = each.value.locale
  description                       = each.value.description
  cascade                           = each.value.cascade
  aws_service                       = each.value.aws_service
  auto_import                       = each.value.auto_import
  allocation_resource_tags          = each.value.allocation_resource_tags
  allocation_min_netmask_length     = each.value.allocation_min_netmask_length
  allocation_max_netmask_length     = each.value.allocation_max_netmask_length
  allocation_default_netmask_length = each.value.allocation_default_netmask_length
  tags                              = each.value.tags
  tags_all                          = each.value.tags_all

  dynamic "source_resource" {
    for_each = each.value.source_resource != null ? [each.value.source_resource] : []
    content {
      resource_id     = source_resource.value.resource_id
      resource_owner  = source_resource.value.resource_owner
      resource_region = source_resource.value.resource_region
      resource_type   = source_resource.value.resource_type
    }
  }
}

