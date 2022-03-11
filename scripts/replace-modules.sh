#! bash -eux

root=$PWD
pushd node_modules/terraform
  go mod edit -replace github.com/chzyer/readline=$root/gomodules/readline
  go mod edit -replace github.com/bgentry/speakeasy=$root/gomodules/speakeasy
  go mod edit -replace github.com/armon/go-metrics=$root/gomodules/go-metrics
  go mod edit -replace github.com/coreos/go-systemd=$root/gomodules/go-systemd
  go mod edit -replace go.etcd.io/etcd=$root/gomodules/etcd
popd
