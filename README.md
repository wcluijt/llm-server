LLM Server
==========

Create a server to run a local Large Language Model (LLM).

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

Start the LLM Server
--------------------

To start the LLM Server, execute the following:
```
cd ~/llm-server;
./start-llm-server.sh;
```

The LLM Server should be available on port `11434`.

If you need to download a model, you can use the following command:
```
sudo docker compose exec ollama ollama pull <model-name>;
```
