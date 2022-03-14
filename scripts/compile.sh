#! bash -eux

__filename=$(readlink -f "$0")
__dirname=$(dirname "$__filename")
__root=$(dirname "$__dirname")

pushd $__root
  pushd node_modules/terraform
    GOOS=js GOARCH=wasm go build -o ../../public/main.wasm
    sed 's/require = require/require = __webpack_require__/g' \
      "$(go env GOROOT)/misc/wasm/wasm_exec.js" > $__root/src/wasm_exec.js
  popd
popd
