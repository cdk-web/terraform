#! bash -eux

root=$PWD
pushd node_modules/terraform
  go mod edit -replace github.com/chzyer/readline=$root/readline
  go mod edit -replace github.com/bgentry/speakeasy=$root/speakeasy
  go mod edit -replace github.com/armon/go-metrics=$root/go-metrics
  go mod edit -replace github.com/coreos/go-systemd=$root/go-systemd
  go mod edit -replace go.etcd.io/etcd=$root/etcd
popd
