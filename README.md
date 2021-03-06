# Terraform CLI compiled for WASM

> this project is now archived and kept here for the sake of brevity and preserving work. you should not use this.

> this project is left here due to current limitations of WASM in Go and lack of DWARF support and the shear size of the
> AWS provider built by Hashicorp when compiled to WASM (>2GB).

this repository has scripts and build tools to compile the terraform cli for wasm.
wasm runtime allows the compiled binary to be used in your web browser and NodeJS!

## quick usage

to, install, patch, compile and run:

```
npm install
npm run compile
npm run serve
```

to update the patch with more changes:

```
npm run make-patch
```

## scripts

- `npm install` brings down the latest version of terraform source and makes it a dummy node module
- `npm postinstall` patches terraform sources in node_modules
- `npm compile` builds it for wasm in node_modules
- `npm serve` fires up a dev server
