# main.tf

# Define a null data source with a local-exec provisioner
# This data source will wait during the plan phase
data "external" "delay_during_plan" {
  program = ["sh", "-c", "sleep 120 && echo '{\"done\": \"true\"}'"]
}

# Example usage of the delayed data source
resource "null_resource" "example" {
  # The resource triggers the delay data source
  depends_on = [data.external.delay_during_plan]

  provisioner "local-exec" {
    command = "echo 'Plan completed with delay.'"
  }
}
