# Terraform CLI Hacks For WASM

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
