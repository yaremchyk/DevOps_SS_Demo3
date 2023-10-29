
resource "aws_ecs_task_definition" "default" {
  family             = "${var.namespace}-ecs-task-definition-${var.environment}"
  execution_role_arn = var.ecs_task_execution_role_arn
  task_role_arn      = var.ecs_task_iam_role_arn

  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = "025389115636.dkr.ecr.eu-north-1.amazonaws.com/app-repo:latest"
      cpu       = var.cpu_units
      memory    = var.memory
      essential = true
      portMappings = [
        {
          containerPort = var.container_port
          hostPort      = 8002
          protocol      = "tcp"
        }
      ]
      # environment : [
      #   {
      #     name : "DbName",
      #     value : local.db_creds.DbName
      #   },
      #   {
      #     name : "DbUsername",
      #     value : local.db_creds.DbUsername
      #   },
      #   {
      #     name : "DbHost",
      #     value : var.db_host
      #   },
      #   {
      #     name : "DbPassword",
      #     value : local.db_creds.DbPassword
      #   }
      # ]
      
    }
  ])
}