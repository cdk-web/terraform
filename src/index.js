import { wbTfFs } from "./fs";
import { Terraform } from "./terraform";
// import for webpack?

const mainTf = `\
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-830c94e3"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
`;

const app = async () => {
  const tf = new Terraform();
  // write a tf file to plan
  // wbTfFs.fs.writeFileSync(`${tf.workDir}/main.tf`, mainTf);
  tf.load();

  // build the DOM
  function component() {
    const initEl = document.createElement("button");
    initEl.innerHTML = "Terraform Init";
    initEl.onclick = tf.init.bind(tf);
    const helpEl = document.createElement("button");
    helpEl.innerHTML = "Terraform Help";
    helpEl.onclick = tf.help.bind(tf);
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
