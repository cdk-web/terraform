import { wbTfFs } from "./fs";
// import for webpack?
import * as exec from "./wasm_exec";

const app = async () => {
  const go = new Go();

  const response = await fetch("main.wasm");
  const buffer = await response.arrayBuffer();
  async function getWasm() {
    return await WebAssembly.instantiate(buffer, go.importObject);
  }
  async function init() {
    go.argv = ["terraform", "init"];
    return go.run((await getWasm()).instance);
  }
  async function help() {
    go.argv = ["js"]; // default
    return go.run((await getWasm()).instance);
  }

  function component() {
    const initEl = document.createElement("button");
    initEl.innerHTML = "Terraform Init";
    initEl.onclick = init;
    const helpEl = document.createElement("button");
    helpEl.innerHTML = "Terraform Help";
    helpEl.onclick = help;
    const app = document.createElement("div");
    const output = document.createElement("div");

    wbTfFs.event.addEventListener("stdout", (out) => {
      console.log(out.detail);
      output.innerHTML = out.detail
        .replace(/\n/g, "<br/>")
        .replace(/\s/g, "&nbsp;");
    });

    app.appendChild(initEl);
    app.appendChild(helpEl);
    app.appendChild(document.createElement("hr"));
    app.appendChild(output);
    return app;
  }

  const app = component();
  document.body.appendChild(app);
};

global.fs = wbTfFs.fs;

app();
