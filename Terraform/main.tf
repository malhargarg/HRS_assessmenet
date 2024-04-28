provider "aws" {
  region = "us-east-1"
}

module "resources" {
  source = "./modules/resources"

  # Define input variables specific to microservices module
  vpc_cidr_block                    = "10.0.0.0/16"
  subnet_cidr_block                 = "10.0.1.0/24"
  availability_zone                 = "us-east-1a"
  cluster_name                      = "my-cluster"
  alb_name                          = "my-alb"
  alb_internal                      = false
  alb_type                          = "application"
  task_family                       = "my-task"
  container_definitions             = <<DEFINITION
[
  {
    "name": "my-container",
    "image": "your-container-image",
    "portMappings": [
      {
        "containerPort": 8080,
        "hostPort": 8080
      }
    ]
  }
]
DEFINITION
  service_name                      = "my-service"
  desired_count                     = 2
  container_name                    = "my-container"
  container_port                    = 8080
  target_group_name                 = "my-target-group"
  target_group_port                 = 8080
  target_group_protocol             = "HTTP"
  route53_zone_name                 = "example.com"
  route53_record_name               = "myservice.example.com"
  route53_record_type               = "A"
  route53_evaluate_target_health    = true
}

output "cluster_id" {
  value = module.resources.cluster_id
}

output "alb_dns_name" {
  value = module.resources.alb_dns_name
}
