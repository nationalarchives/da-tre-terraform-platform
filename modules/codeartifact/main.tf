# Define the TRE v2 CodeArtifact domain
resource "aws_codeartifact_domain" "tre_v2" {
  domain = "${var.prefix}-ca-domain"
}

# Define the upstream PyPi repository for public artifacts
resource "aws_codeartifact_repository" "tre_v2_upstream" {
  # Not currently using ${var.prefix} as resource already created manually
  repository = "pypi-store"
  domain     = aws_codeartifact_domain.tre_v2.domain
}

# Define the TRE v2 CodeArtifact repository
resource "aws_codeartifact_repository" "tre_v2" {
  repository = "${var.prefix}-ca-artifacts"
  domain     = aws_codeartifact_domain.tre_v2.domain
  description = "A repository to store the packages associated with The National Archives Transformation Engine Project"

  upstream {
    repository_name = aws_codeartifact_repository.tre_v2_upstream.repository
  }
}
