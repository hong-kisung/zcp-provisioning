output "worker_pool_name" {
  value = "${data.template_file.worker_pool_name.rendered}"
}

output "machine_type" {
  value = "${data.template_file.machine_type.rendered}"
}