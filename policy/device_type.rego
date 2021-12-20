package terraform

import input as tfplan

array_contains(arr, elem) {
  arr[_] = elem
}
 
allowed_types = [
  "t1.small.x86",
]
 
deny[reason] {
	resources := tfplan.resource_changes[0]
  plan := resources.change.after.plan
  not array_contains(allowed_types,plan)
  reason := sprintf("Instance type %s not allowed.",[plan])
}
