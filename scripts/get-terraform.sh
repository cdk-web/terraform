#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

TerraformRepo=$(node -p "require('$__root/package.json').terraform.repo")
TerraformBranch=$(node -p "require('$__root/package.json').terraform.branch")

pushd $__root
  rm -rf terraform terraform-src.tgz
  git clone --depth=1 --branch ${TerraformBranch} ${TerraformRepo}
  pushd terraform
    npm init -y
    npm pack
  popd
  mv terraform/terraform-1.0.0.tgz terraform-src.tgz && rm -rf terraform
popd
