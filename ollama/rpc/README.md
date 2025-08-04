Ollama RPC Server
=================

Create servers to run a local Large Language Model (LLM) and distribute
the load.

Designate one machine to be the primary server and the others to be the
secondary RPC servers.  For each machine, the following steps should be
performed to set them up.

Setup operating system using netboot.xyz
----------------------------------------

Obtain a bootable USB drive from netboot.xyz (https://netboot.xyz/docs/booting/usb/).

Boot from the USB.  Once booted, there should be a menu to navigate to
the Debian 12 network installation:
```
Linux Network Installs (64-bit) > Debian > Debian 12.0 (bookworm) > Specify preseed url
```

For the preseed URL, type in the following:
```
http://raw.githubusercontent.com/wcluijt/llm-server/refs/heads/main/preseed.cfg
```

Then follow the installer prompts.

**NOTE:** Be aware of the installation device path when you select a
disk to install the system to.  You will need that path for the boot
loader configuration step.  During installation, it is possible that
the USB drive is defined as `/dev/sda` when you might expect `/dev/sda`
to be the primary disk (but is actually `/dev/sdf` for example).

Setup LLM Server Prerequisites
------------------------------

Once the server is created, log in with the `llm` user, clone this
repository, and execute the `setup-llm-server-prerequisites.sh` script.
```
cd ~;
git clone https://github.com/wcluijt/llm-server;
cd ~/llm-server;
./setup-llm-server-prerequisites.sh;
```

Then reboot the server to make sure the graphics drivers are loaded.
```
sudo systemctl reboot;
```

Setup Ollama RPC Server Prerequisites
-------------------------------------

Once the LLM Server prerequisites are installed, execute the
`setup-ollama-rpc-GH-10844.sh` script.
```
cd ~/llm-server/ollama/rpc;
./setup-ollama-rpc-GH-10844.sh;
```

Start the Secondary Ollama RPC Server(s)
----------------------------------------

To start the Secondary Ollama RPC Server(s), execute the following:
```
cd ~/llm-server/ollama/rpc;
./start-ollama-rpc.sh;
```

The Secondary Ollama RPC Server(s) should be available on port `50052`.

Take note of the IP Address of this server since you will need to
provide it to the Primary Ollama RPC Server.
```
ip addr show;
```

Start the Primary Ollama RPC Server
-----------------------------------

To start the Primary Ollama RPC Server, gather the IP Address and port
of the Secondary Ollama RPC Server(s) and execute the following:
```
cd ~/llm-server/ollama/rpc;
OLLAMA_RPC_SERVERS="<IP_Address_1>:50052,<IP_Address_2>:50052" ./start-ollama-serve.sh;
```

The Primary Ollama RPC Server should be available on port `11434`.

If you need to download a model, you can use the following command:
```
cd ~/llm-server/ollama/rpc;
./send-ollama-command.sh pull <model-name>;
```
