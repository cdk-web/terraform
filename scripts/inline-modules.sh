#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

if [ -d $__root/terraform-provider-local ]
then
  pushd $__root/terraform-provider-local
    find . -type f -name '*.go' -exec sed -i -e 's,github.com/terraform-providers/terraform-provider-local,terraform-provider-local,g' {} \;
    find . -type f -name 'go.mod' -exec sed -i -e 's,github.com/terraform-providers/terraform-provider-local,terraform-provider-local,g' {} \;
  popd
fi

if [ -d $__root/terraform-provider-aws ]
then
  pushd $__root/terraform-provider-aws
    find . -type f -name '*.go' -exec sed -i -e 's,github.com/hashicorp/terraform-provider-aws,terraform-provider-aws,g' {} \;
    find . -type f -name 'go.mod' -exec sed -i -e 's,github.com/hashicorp/terraform-provider-aws,terraform-provider-aws,g' {} \;
  popd
fi
