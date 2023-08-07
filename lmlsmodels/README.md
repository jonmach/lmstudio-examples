# Link LM Studio files to another directory

With many new Chat clients becoming available, it's normal to keep multiple models in a shared directory and reference all of them from multiple clients while testing.  However, The LM Studio uses a specific directory format to hold it's models: **Publisher** / **repoId** / **modelFile**.</br>

One way to retain the LM Studio content and make it acessible to a shared directory is to use unix file links. This creates a pointer (within another directory) to your existing content.  It means you don't actually copy the file and therefore don't waste excessive space.

If you are trying to link across file systems you will need to use the 's' symbolic option.

## Usage

```
lmslmodels -m <LMS model directory> [-t <target directory>] [-fivsl]
    
  m: Specifies the source LM Studio model directory
  t: Specifies the target directory. If you don't provide a target directory,
     then it will by default link to files in the current directory.
  f: Force Link.  If you have a file with the same name as your target link,
     then it will remove the existing file and make a new link.
  i: Interactive - confirm each potential overwrite
  v: Verbose. Show additional detail while processing
  s: Symbolic link. Creates a pointer instead of a hard link to the Unix inode.
     This can be less reliable and not always honoured by tools.
     You must use this if you are linking across file systems
  l: List the available model files in the source model directory
```

Examples:

1) List all files in the LM Studio model directory

```
$ ./lmslmodels.sh -m ~/.cache/lm-studio/ -l
Listing matching files... no linking will be done
.../.cache/lm-studio/models/TheBloke/samantha-1.1-llama-7B-GGML/samantha-1.1-llama-7b.ggmlv3.q6_K.bin
.../.cache/lm-studio/models/TheBloke/Upstage-Llama-2-70B-instruct-v2-GGML/upstage-llama-2-70b-instruct-v2.ggmlv3.q5_K_M.bin
.../.cache/lm-studio/models/TheBloke/OpenAssistant-Llama2-13B-Orca-8K-3319-GGML/openassistant-llama2-13b-orca-8k-3319.ggmlv3.q8_0.bin
.../.cache/lm-studio/models/TheBloke/StableBeluga-13B-GGML/stablebeluga-13b.ggmlv3.q6_K.bin
.../.cache/lm-studio/models/TheBloke/llama2_70b_chat_uncensored-GGML/llama2_70b_chat_uncensored.ggmlv3.q5_K_M.bin
.../.cache/lm-studio/models/TheBloke/Llama-2-7B-Chat-GGML/llama-2-7b-chat.ggmlv3.q6_K.bin
.../.cache/lm-studio/models/TheBloke/Llama-2-70B-Chat-GGML/llama-2-70b-chat.ggmlv3.q5_K_M.bin
.../.cache/lm-studio/models/TheBloke/Chronos-Hermes-13B-v2-GGML/chronos-hermes-13b-v2.ggmlv3.q8_0.bin
.../.cache/lm-studio/models/TheBloke/Chronos-Beluga-v2-13B-GGML/chronos-beluga-v2-13b.ggmlv3.q8_0.bin
.../.cache/lm-studio/models/TheBloke/Nous-Hermes-13B-GGML/nous-hermes-llama2-13b.ggmlv3.q6_K.bin
.../.cache/lm-studio/models/s3nh/orca_mini_3b-GGML/orca_mini_3b.ggmlv3.q8_0.bin
```

2) Link all 13B models to a target directory /tmp

```
$ ./lmslmodels.sh -m ~/.cache/lm-studio -t /tmp -p 13b -v
/tmp/openassistant-llama2-13b-orca-8k-3319.ggmlv3.q8_0.bin => ~/.cache/lm-studio/models/TheBloke/OpenAssistant-Llama2-13B-Orca-8K-3319-GGML/openassistant-llama2-13b-orca-8k-3319.ggmlv3.q8_0.bin
/tmp/stablebeluga-13b.ggmlv3.q6_K.bin => ~/.cache/lm-studio/models/TheBloke/StableBeluga-13B-GGML/stablebeluga-13b.ggmlv3.q6_K.bin
/tmp/chronos-hermes-13b-v2.ggmlv3.q8_0.bin => ~/.cache/lm-studio/models/TheBloke/Chronos-Hermes-13B-v2-GGML/chronos-hermes-13b-v2.ggmlv3.q8_0.bin
/tmp/chronos-beluga-v2-13b.ggmlv3.q8_0.bin => ~/.cache/lm-studio/models/TheBloke/Chronos-Beluga-v2-13B-GGML/chronos-beluga-v2-13b.ggmlv3.q8_0.bin
/tmp/nous-hermes-llama2-13b.ggmlv3.q6_K.bin => ~/.cache/lm-studio/models/TheBloke/Nous-Hermes-13B-GGML/nous-hermes-llama2-13b.ggmlv3.q6_K.bin
$
$ ls -l /tmp/*.bin
...  13791349888  6 Aug 18:46 /tmp/chronos-beluga-v2-13b.ggmlv3.q8_0.bin
...  13831378592  6 Aug 18:48 /tmp/chronos-hermes-13b-v2.ggmlv3.q8_0.bin
...  10830311072  2 Aug 22:38 /tmp/nous-hermes-llama2-13b.ggmlv3.q6_K.bin
...  13831204256  7 Aug 07:29 /tmp/openassistant-llama2-13b-orca-8k-3319.ggmlv3.q8_0.bin
...  staff  10678850688  2 Aug 22:37 /tmp/stablebeluga-13b.ggmlv3.q6_K.bin

```

3) link all chronos models in the LM Studio model directory to /tmp. 

```
$ ./lmslmodels.sh -m ~/.cache/lm-studio -p "chronos" -t /tmp -v
ln: /tmp/chronos-hermes-13b-v2.ggmlv3.q8_0.bin: File exists
ln: /tmp/chronos-beluga-v2-13b.ggmlv3.q8_0.bin: File exists
```

4) Force the (re)linking for all chronos models in LM Studio model direction to /tmp

```
$ ./lmslmodels.sh -m ~/.cache/lm-studio -p "chronos" -t /tmp -v -f
/tmp/chronos-hermes-13b-v2.ggmlv3.q8_0.bin => ~/.cache/lm-studio/models/TheBloke/Chronos-Hermes-13B-v2-GGML/chronos-hermes-13b-v2.ggmlv3.q8_0.bin
/tmp/chronos-beluga-v2-13b.ggmlv3.q8_0.bin => ~/.cache/lm-studio/models/TheBloke/Chronos-Beluga-v2-13B-GGML/chronos-beluga-v2-13b.ggmlv3.q8_0.bin
```

