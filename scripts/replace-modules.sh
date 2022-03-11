#! bash -eux

root=$PWD
pushd node_modules/terraform
  go mod edit -replace github.com/chzyer/readline=$root/tfweb/readline
  go mod edit -replace github.com/bgentry/speakeasy=$root/tfweb/speakeasy
  go mod edit -replace github.com/armon/go-metrics=$root/tfweb/go-metrics
  go mod edit -replace github.com/coreos/go-systemd=$root/tfweb/go-systemd
  go mod edit -replace go.etcd.io/etcd=$root/tfweb/etcd
popd
