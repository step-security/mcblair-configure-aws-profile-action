[![StepSecurity Maintained Action](https://raw.githubusercontent.com/step-security/maintained-actions-assets/main/assets/maintained-action-banner.png)](https://docs.stepsecurity.io/actions/stepsecurity-maintained-actions)

# Configure AWS Profile Action

A secure GitHub Action to configure multiple named AWS CLI profiles using OIDC role assumption. Each invocation assumes
an IAM role and persists the temporary credentials as a named AWS CLI profile, allowing multiple AWS accounts to be used
simultaneously within the same workflow.

> [`step-security/configure-aws-credentials`](https://github.com/step-security/configure-aws-credentials) alone can only hold one set of AWS environment variables at a time. This
> action solves that by writing credentials to named profiles, enabling parallel multi-account usage.

## Prerequisites

- An IAM role configured to trust GitHub Actions via OIDC (`token.actions.githubusercontent.com`)
- `id-token: write` permission in your workflow

## Inputs

| Input          | Required | Default     | Description                            |
|----------------|----------|-------------|----------------------------------------|
| `role-arn`     | yes      | —           | ARN of the IAM role to assume via OIDC |
| `profile-name` | yes      | —           | Name of the AWS CLI profile to create  |
| `region`       | no       | `us-west-2` | AWS region                             |

## Usage

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      id-token: write
    steps:
      - name: Checkout
        uses: actions/checkout@v7

      - name: Configure staging profile
        uses: step-security/mcblair-configure-aws-profile-action@v1
        with:
          role-arn: arn:aws:iam::<STAGING_ACCOUNT_ID>:role/<ROLE_NAME>
          profile-name: staging

      - name: Configure production profile
        uses: step-security/mcblair-configure-aws-profile-action@v1
        with:
          role-arn: arn:aws:iam::<PROD_ACCOUNT_ID>:role/<ROLE_NAME>
          profile-name: production
          region: us-east-1

      - name: Use staging profile
        run: aws s3 ls --profile staging

      - name: Use production profile
        run: aws s3 ls --profile production
```
