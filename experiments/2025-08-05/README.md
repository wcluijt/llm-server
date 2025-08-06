2025-08-05
==========

First full setup created.

The current code is based on the GitHub Ollama #10844 Pull Request
(https://github.com/ollama/ollama/pull/10844).  The
`ollama/rpc/GH-10844.patch` file is from
https://github.com/gkpln3/ollama/tree/feat/rpc (commit
84aa6d0a82ff6fb7d68287b7031846d97e2127b5) with an adjustment to resolve
a conflict in the `llm/server.go` file.  This patch is applied to the
https://github.com/ollama/ollama main branch code at commit
4183bb0574a28b73276efef944107d0c45d79c95 (which seems to have more
commits in the main branch now since this patch file was created).

Various shell scripts and Debian 12 preseed.cfg files were created to
allow this setup to be reproduced.  It seems to work well enough, but
the old hardware being used might contribute to the time needed for
full setup completion.

Using the netboot.xyz USB stick loader with a Debian 12 preseed URL
might have a `"priority=critical"` kernel parameter.  This seems to
cause the hostname to default to "debian" and use the router DHCP
settings rather than the specified `llm0*/preseed.cfg` static IP
address values.  So the local IP addresses for the LLM servers were the
following:
```
llm01: 192.168.0.157
llm02: 192.168.0.140
llm03: 192.168.0.114
```

The `llm01` server is the primary server while `llm02` and `llm03` are
secondary RPC servers that connect to `llm01`.  Within the `llm01`
server, the `/home/llm/llm-server/ollama/rpc/OLLAMA_RPC_SERVERS.txt`
file was updated to include the following on one line:
```
192.168.0.140:50052,192.168.0.114:50052
```

These IP address values should be within the result files.

The server commands run in a `screen`, which is triggered in the cron
on reboot (see the related `llm0*/preseed.cfg` files, search for
"late_command").  After using SSH to connect to the server, the command
to connect to the `screen` would be:
```
screen -dr ollama_rpc;
```

The result files were captured from the `screen` command output with
the following sequence:

press `Ctrl+a`, type `:`, type `hardcopy -h /home/llm/llm01.txt`,
press `Enter`.

For reference, detaching from a `screen` would be `Ctrl+a+d` (holding
down `Ctrl`, then holding `a`, then pressing `d`).

The content of the `results/llm01.txt` file was adjusted to replace
GPU ID references with `GPU-<ID>`.

The model files were downloaded on the `llm01` server with the
following commands:
```
cd ~/llm-server/ollama/rpc/;
./send-ollama-command.sh pull llama3.2;
./send-ollama-command.sh pull deepseek-r1;
```

The content of the `results/llm01.txt` file should show the output
related to these commands (search for "downloading").

I used PHPStorm (`version 2025.1.4.1, Build #PS-251.27812.52, Runtime
version 21.0.7+9-b895.130 x86_64 (JCEF 122.1.9)`) and the AI Assistant
feature to connect to the `llm01` IP address.  In PHPStorm `Settings >
Tools > AI Assistant > Models`, the `Enable Ollama` and `Offline mode`
checkboxes were enabled.  Most likely the reason that there are many
calls to `/api/tags` in the `results/llm01.txt` output is because of
PHPStorm querying the available models.

The prompt used was "tell me a story" in this session for both the
`llama3.2` and `deepseek-r1` models.  In the `results/llm01.txt` file,
searching for "/api/chat" shows four POST request instances.  This is
most likely from PHPStorm sending the initial prompt and then another
prompt to summarize the content of that chat session to give a name in
the History listing of the AI Assistant window.

While the duration of these requests seems long, this is due to the
*ancient* hardware (`Dell XPS 8900: October 2015, Dell XPS 420: October
2007`) that I have access to at the moment.  But they do appear to
connect and send information over the network based on the
`results/llm02.txt` and `results/llm03.txt` file output.  The
`create_backend: using CPU backend` output is related to the `llm02`
and `llm03` servers not having a `AMD RV670 [Radeon HD 3870]` GPU
driver loaded (as seen in the related `server-specs.txt` file).  This
is probably due to the very old hardware, despite using many possible
AMD driver packages in the `setup-llm-server-prerequisites.sh` script.

So far, so good.

