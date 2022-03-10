# Terraform CLI Hacks For WASM

Trying to get the TF CLI to compile for wasm.

- [Clone the terraform CLI](https://github.com/hashicorp/terraform)
- [Clone this repository into the cli](https://github.com/mneil/tfweb-tfcli-wasml)
  - `git clone git@github.com:mneil/tfweb-tfcli-wasml.git tfweb`

Patch these modules:

```sh
go mod edit -replace github.com/chzyer/readline=$PWD/tfweb/readline
go mod edit -replace github.com/bgentry/speakeasy=$PWD/tfweb/speakeasy
go mod edit -replace github.com/armon/go-metrics=$PWD/tfweb/go-metrics
go mod edit -replace github.com/coreos/go-systemd=$PWD/tfweb/go-systemd
go mod edit -replace go.etcd.io/etcd=$PWD/tfweb/etcd
```

Build Terraform for WASM

```sh
GOOS=js GOARCH=wasm go build -o main.wasm
```

Or try with tinygo. You'll need to replace the trace module

```sh
go mod edit -replace go.opencensus.io=$PWD/tfweb/opencensus
tinygo build -o wasm.wasm -target wasm ./main.go
```
