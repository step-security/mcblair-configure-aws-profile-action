#!/usr/bin/env bash
set -euo pipefail

: "${PROFILE_NAME:?Missing PROFILE_NAME}"
: "${REGION:?Missing REGION}"

aws configure set region "$REGION" --profile "$PROFILE_NAME"
aws configure set aws_access_key_id "$AWS_ACCESS_KEY_ID" --profile "$PROFILE_NAME"
aws configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY" --profile "$PROFILE_NAME"
aws configure set aws_session_token "$AWS_SESSION_TOKEN" --profile "$PROFILE_NAME"

echo "AWS_ACCESS_KEY_ID=" >> "$GITHUB_ENV"
echo "AWS_SECRET_ACCESS_KEY=" >> "$GITHUB_ENV"
echo "AWS_SESSION_TOKEN=" >> "$GITHUB_ENV"

aws sts get-caller-identity --profile "$PROFILE_NAME"
