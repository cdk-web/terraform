#! bash -eux

rm -rf terraform terraform-latest.tgz
git clone --depth=1 https://github.com/hashicorp/terraform
pushd terraform
  npm init -y
  npm pack
popd
mv terraform/terraform-1.0.0.tgz terraform-latest.tgz && rm -rf terraform
