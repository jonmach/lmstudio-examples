# OpenAI Chat Completions Hello World (Python)

This is a very simple Hello World program that shows how to connect to your local server and provides a sample prompt.

## Usage

In the LM Studio client, go to the 'Local Inference Server' <--> tab.

1. Choose your Model (e.g. TheBloke / Llama-2-7B-****Chat-GGML / llama-2-7b-chat.ggmlv3.q6_K.bin)
2. Choose your Server Port (e.g. 1234)
3. Click on 'Start Server'

	You should see something like the following:
	
```	
	...[INFO] [LM STUDIO SERVER] Success! HTTP server listening on port 1234.
	...[INFO] [LM STUDIO SERVER] Supported endpoints:
	...[INFO] [LM STUDIO SERVER] ->	GET  http://localhost:1234/v1/models
	...[INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/chat/completions
	...[INFO] [LM STUDIO SERVER] ->	POST http://localhost:1234/v1/completions
	...[INFO] [LM STUDIO SERVER] Logs are saved into /tmp/lmstudio-server-log.txt.
	...[INFO] [LM STUDIO SERVER] Stopping server.
	...[INFO] [LM STUDIO SERVER] Server stopped.
```
4. On your command prompt, you can then run the HelloWorld.py programme, and you should see something like the following

```console
$ python HelloWorld.py

Your prompt: Hello! Please give me 3 words that rhyme with 'world'

LLM's response:

I'm happy to help you with that! Here are three words that rhyme with "world":

1. Gold
2. Bold
3. Old Old
```

## Note about prompt format
Chat and Instruct models typically expect a certain prompt format (e.g. `### Instruction` and `### Response` or Llama2's `[INST]` and `[/INST]`.)
As of this writing, LM Studio (v0.1.11 or older) requires you to preformat your `content` fields with the model's expected prompt style.
