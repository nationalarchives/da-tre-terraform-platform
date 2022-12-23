# Define the TRE v2 CodeArtifact domain
resource "aws_codeartifact_domain" "tre_v2" {
  domain = "tre-ca-domain"
}

# Define the upstream PyPi repository for public artifacts
resource "aws_codeartifact_repository" "tre_v2_upstream" {
  repository = "pypi-store"
  domain     = aws_codeartifact_domain.tre_v2
}

# Define the TRE v2 CodeArtifact repository
resource "aws_codeartifact_repository" "tre_v2" {
  repository = "tre-ca-artifacts"
  domain     = aws_codeartifact_domain.tre_v2

  upstream {
    repository_name = aws_codeartifact_repository.tre_v2_upstream.repository
  }
}
