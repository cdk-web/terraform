#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

pushd $__root
  pushd node_modules/terraform
    GOOS=js GOARCH=wasm go build -o ../../public/main.wasm
    cp "$(go env GOROOT)/misc/wasm/wasm_exec.js" ../../src
  popd
popd
