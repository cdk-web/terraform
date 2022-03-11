import { fs } from "memfs";
import process from "process";

function component() {
  const element = document.createElement("div");
  fs.writeFileSync("/script.sh", "sudo rm -rf *");
  element.innerHTML = fs.readFileSync("/script.sh");
  return element;
}

global.fs = fs;
global.process = process;

document.body.appendChild(component());
