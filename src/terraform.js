// this causes the actual Go/WASM vm to be created and initialized
import "./wasm_exec"

import { wbTfFs } from "./fs";

export class Terraform extends Go {
  wasm;
  logLevel = "TRACE";
  logPath = "/tmp/log.out";
  workDir = "/app";
  user = "terraform";
  homeDir = "/home/terraform";

  constructor() {
    super();
    this.env.USER = this.user;
    this.env.HOME = this.homeDir;
    this.env.TF_LOG = this.logLevel;
    // setup logging for terraform
    this.env.TF_LOG_PATH = this.logPath;
    // create user home directory
    wbTfFs.fs.mkdirSync(this.homeDir, { recursive: true });
    // create log path directory
    wbTfFs.fs.mkdirSync(this.logPath.split("/").slice(0, -1).join("/"), {
      recursive: true,
    });
    // create app directory
    wbTfFs.fs.mkdirSync(this.workDir, { recursive: true });
    process.cwd = () => this.workDir;
  }

  async load() {
    const response = await fetch("main.wasm");
    this.wasm = await response.arrayBuffer();
  }

  async command(args) {
    this.argv = ["terraform", ...args];
    const res = await super.run(
      (await WebAssembly.instantiate(this.wasm, this.importObject)).instance
    );
    // Debug log to console
    console.log(fs.readFileSync(this.env.TF_LOG_PATH, { encoding: "utf8" }));
    return res;
  }

  async init() {
    return await this.command(["init"]);
  }
  async help() {
    return await this.command([]);
  }
}
