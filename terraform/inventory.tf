######################
# Generate inventory
######################

data "template_file" "inventory" {
  template = "${file("${path.module}/templates/inventory.tpl")}"

  vars {    
    connection_strings_master = "${join("\n",formatlist("%s ansible_ssh_host=%s ip=%s", aws_instance.controller.*.tags.Name, aws_instance.controller.*.public_ip, aws_instance.controller.*.private_ip))}"
    connection_strings_node = "${join("\n", formatlist("%s ansible_ssh_host=%s ip=%s", aws_instance.worker.*.tags.Name, aws_instance.worker.*.public_ip, aws_instance.worker.*.private_ip))}"    
    list_master = "${join("\n",aws_instance.controller.*.tags.Name)}"
    list_node = "${join("\n",aws_instance.worker.*.tags.Name)}"    
  }
}

resource "null_resource" "inventories" {
  depends_on = ["aws_elb.kubernetes_api","aws_instance.controller","aws_instance.worker"]

  provisioner "local-exec" {
    command = "echo '${data.template_file.inventory.rendered}' > ../inventory/hosts"
  }

  triggers {
    template = "${data.template_file.inventory.rendered}"
  }

}
