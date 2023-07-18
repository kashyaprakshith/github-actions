# Lambda@Edge and ACM, when used with CloudFront, need to be used in the US East region.
# Thus, we need a separate AWS provider for that region, which can be used with an alias.
# Make sure you customize this block to match your regular AWS provider configuration.
# https://www.terraform.io/docs/configuration/providers.html#multiple-provider-instances



provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

module "my_redirect" {
  # Available inputs: https://github.com/futurice/terraform-utils/tree/master/aws_domain_redirect#inputs
  # Check for updates: https://github.com/futurice/terraform-utils/compare/v11.0...master
  source = "git::ssh://git@github.com/futurice/terraform-utils.git//aws_domain_redirect?ref=v11.0"

  redirect_domain = "go.example.com"
  redirect_url    = "https://www.futurice.com/careers/"
}
