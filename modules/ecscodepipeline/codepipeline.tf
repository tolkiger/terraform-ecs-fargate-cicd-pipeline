resource "aws_s3_bucket" "pipeline" {
  bucket = "codepipeline-${var.aws_region}-123456789"
}

resource "aws_codepipeline" "pipeline" {
  count = var.deploy_approval_enabled == 0 ? 1 : 0

  name = var.pipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.pipeline.bucket
    type = "S3"
    encryption_key {
      id = var.s3_artifact_kms_key
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name = "Source"
      category = "Source"
      owner = "AWS"
      provider = "CodeCommit"
      version = "1"
      output_artifacts = ["source-output"]

      configuration = {
        RepositoryName = aws_codecommit_repository.protenus.repository_name
        BranchName = var.source_branch
        PollForSourceChanges = false
      }
    }
  }

  stage {
    name = "Build"

    action {
      name = "Build"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = ["source-output"]
      output_artifacts = ["build-output"]

      configuration = {
        ProjectName = var.build_name
      }
    }
  }

  stage {
    name = "DeployECS"

    action {
      name = "Deploy"
      category = "Deploy"
      owner = "AWS"
      provider = "ECS"
      input_artifacts = ["build-output"]
      version = "1"

      configuration = {
        ClusterName = var.ecs_cluster_name
        ServiceName = var.ecs_service_name
        FileName = "imagedefinitions.json"
      }
    }
  }
}
