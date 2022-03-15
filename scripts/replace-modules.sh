#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

pushd $__root/node_modules/terraform
  go mod edit -replace github.com/chzyer/readline=$__root/gomodules/readline
  go mod edit -replace github.com/bgentry/speakeasy=$__root/gomodules/speakeasy
  go mod edit -replace github.com/armon/go-metrics=$__root/gomodules/go-metrics
  go mod edit -replace github.com/coreos/go-systemd=$__root/gomodules/go-systemd
  go mod edit -replace go.etcd.io/etcd=$__root/gomodules/etcd
  pushd internal/command
    mkdir -p bundled-providers
    pushd bundled-providers
      
      git clone --depth 1 --branch v4.5.0 https://github.com/hashicorp/terraform-provider-aws.git
      sed -i "1s/.*/module terraform-provider-aws/" terraform-provider-aws/go.mod
      mv terraform-provider-aws/internal/* terraform-provider-aws
      rm terraform-provider-aws/main.go

      git clone --depth 1 --branch v2.2.2 https://github.com/hashicorp/terraform-provider-local.git
      sed -i "1s/.*/module terraform-provider-local/" terraform-provider-local/go.mod
      mv terraform-provider-local/internal/* terraform-provider-local
      rm terraform-provider-local/main.go

    popd
  popd
  go mod edit -replace terraform-provider-aws=$__root/node_modules/terraform/internal/command/bundled-providers/terraform-provider-aws
  go mod edit -replace terraform-provider-local=$__root/node_modules/terraform/internal/command/bundled-providers/terraform-provider-local
  git init
  git add -A
  git commit -m "unpatched"
popd
