import { WasmFs } from "@wasmer/wasmfs";

class WebTfFs extends WasmFs {
  event = new EventTarget();
  lastOut = "";
  lastChar = 0;

  constructor() {
    super();
    this.readStdOut();
  }

  readStdOut() {
    this.getStdOut().then((response) => {
      if (response == this.lastOut) {
        return setTimeout(() => {
          this.readStdOut();
        }, 100);
      }
      this.event.dispatchEvent(
        new CustomEvent("stdout", { detail: response.slice(this.lastChar) })
      );
      this.lastOut = response;
      this.lastChar = response.length;
      this.readStdOut();
    });
  }
}

export const wbTfFs = new WebTfFs();
