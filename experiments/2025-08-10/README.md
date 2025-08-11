2025-08-10
==========

The current code is now based on the most recent ollama main branch at
commit 2c776f07805022221e7640a643777818528d0a27.  The existing patch
file (`ollama/rpc/GH-10844.patch`) did not need to be modified in order
to apply to the git repository code.

The local IP addresses for the LLM servers were the following:
```
llm01: 192.168.0.157
llm02: 192.168.0.140
llm03: 192.168.0.114
```

The `llm02` and `llm03` server setup scripts were updated to allow a
GPU driver to be loaded, but the older hardware is using a driver that
may not be recognized by the Ollama RPC system at the moment.  Within
the `results/llm02.txt` and `results/llm03.txt` output, the line
`create_backend: using CPU backend` shows that the GPU is not being
used with the current configuration.

Other than that, the setup is mostly the same as the previous
`2025-08-05` experiment.

The content of the `results/llm01.txt` file was adjusted to replace
GPU ID references with `GPU-<ID>`.

The model files were downloaded on the `llm01` server with the
following commands:
```
cd ~/llm-server/ollama/rpc/;
./send-ollama-command.sh pull llama3.2;
./send-ollama-command.sh pull deepseek-r1;
./send-ollama-command.sh pull gpt-oss;
```

Note that the `gpt-oss` model was released very recently.

The prompt used was "tell me a story" in this session for the
`llama3.2`, `gpt-oss`, and `deepseek-r1` models.  It seems that the
`gpt-oss` model didn't load like the other models did within the
`results/llm01.txt` output.  I may have to retry that prompt with the
`gpt-oss` model.

