# Unit Tests for tf-atom-ssm-parameter-aws
#
# These tests use a mock AWS provider — no real AWS calls are made.
# Run with:      terraform test -test-directory=tests/unit
# Run verbose:   terraform test -test-directory=tests/unit -verbose
# Run one test:  terraform test -test-directory=tests/unit -run "creates_when_enabled"
#
# NOTE: Assertions target plan-KNOWN values only (the tf-label id string and
# the `enabled` flag). Computed AWS attributes (arn/id/version) are unknown
# under a mock provider and must not be asserted on.

mock_provider "aws" {}

# Standard tf-label inputs shared by every run block below.
variables {
  namespace = "eg"
  stage     = "test"
  name      = "thing"
  value     = "example-value"
}

# ---------------------------------------------------------------------------
# Test: module is enabled by default and produces the expected tf-label id.
# ---------------------------------------------------------------------------
run "creates_when_enabled" {
  command = plan

  assert {
    condition     = output.enabled == true
    error_message = "Module should report enabled = true when enabled is left at its default."
  }

  assert {
    condition     = module.this.id == "eg-test-thing"
    error_message = "tf-label id should be 'eg-test-thing' for namespace=eg, stage=test, name=thing."
  }

  assert {
    condition     = length(aws_ssm_parameter.this) == 1
    error_message = "Exactly one aws_ssm_parameter should be planned when enabled."
  }

  assert {
    condition     = aws_ssm_parameter.this[0].name == "eg-test-thing"
    error_message = "Parameter name should default to the tf-label id."
  }

  assert {
    condition     = aws_ssm_parameter.this[0].type == "String"
    error_message = "Parameter type should default to String."
  }
}

# ---------------------------------------------------------------------------
# Test: setting enabled = false disables the module (creates no resources).
# ---------------------------------------------------------------------------
run "disabled_creates_nothing" {
  command = plan

  variables {
    enabled = false
  }

  assert {
    condition     = output.enabled == false
    error_message = "Module should report enabled = false when enabled = false is passed."
  }

  assert {
    condition     = length(aws_ssm_parameter.this) == 0
    error_message = "No aws_ssm_parameter should be planned when disabled."
  }

  assert {
    condition     = output.id == null && output.arn == null
    error_message = "id and arn outputs should be null when the module is disabled."
  }
}
