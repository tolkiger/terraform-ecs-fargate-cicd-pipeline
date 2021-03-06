aws_region   = "us-east-1"
environment  = "prod-vpc"
cluster_name = "hello-world"
stage        = "Production"

app_name                   = "hello-world"
asg_min_capacity           = "2"
asg_max_capacity           = "4"
lb_ssl_cert                = "arn:aws:acm:us-east-1:123456789123:certificate/123456789012-1234-1234-1234-12345678"
build_compute_type         = "BUILD_GENERAL1_SMALL"
build_image                = "aws/codebuild/standard:5.0"
build_timeout              = "10"
environment_type           = "LINUX_CONTAINER"
ecs_container_image        = "123456789012.dkr.ecr.us-east-1.amazonaws.com/hello-world:latest"
source_repo                = "hello-world"
source_branch              = "master"
route53_name               = "hello.test.com"
group_tag                  = "protenus"
role_tag                   = "skillset-assessment"
team_tag                   = "protenus-infra"
lb_hc_path                 = "HealthCheck"
lb_internal                = "false"
lb_tg_deregistration_delay = 10
host_port                  = 80
container_port             = 80
protocol                   = "tcp"
ecs_desired_count          = "2"
ecs_memory                 = "2048"
ecs_cpu                    = "512"
container_memory           = "1024"
container_cpu              = "256"
deployment_maximum_percent = "250"
deployment_minimim_percent = "100"
vpc_name                   = "main"
