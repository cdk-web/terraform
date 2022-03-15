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
  git init
  git add -A
  git commit -m "unpatched"
popd
