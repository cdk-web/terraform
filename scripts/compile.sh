#! bash -eux

pushd node_modules/terraform
  GOOS=js GOARCH=wasm go build -o ../../public/main.wasm
  cp "$(go env GOROOT)/misc/wasm/wasm_exec.js" ../../src
popd
