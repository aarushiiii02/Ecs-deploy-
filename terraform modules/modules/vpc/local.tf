locals {
  merged_map = merge(var.common_tags , var.tags)
}