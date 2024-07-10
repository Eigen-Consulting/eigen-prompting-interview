# Prompting Interview Session README

Welcome to the interview! This session focuses on prompting LLMs to get desired outputs. It's one of the most important things we do at Eigen, and we want to get a feel for your intuition with the skill. It's ok if you haven't had to do it for work; if you've been using tools like ChatGPT, it's very similar.


## What to expect

During this interview session, you can expect:

1. A focus on practical prompting skills
2. Hands-on exercises using Promptfoo
3. Evaluation of your ability to craft effective prompts
4. Discussion of your thought process and reasoning
5. Opportunities to demonstrate your problem-solving skills
6. Feedback on your prompting techniques
7. Questions about your experience with LLMs and prompt engineering
8. Questions about LLMs at a high level and understanding your intuitions

The format of the interview is as follows:
- There are 4 levels
- Each level tests a different skill in prompt engineering
- Some levels have right answers (verified by test cases, and there can be multiple right answers), and some levels are more open-ended

Each level, you'll be switching between a `prompts.txt` file, a `description.md` for each level's instructions, and a `tests.yaml` where you can write test cases. The folder attached has a dummy problem that emulates the structure.

If you need to brush up on prompt engineer and LLM's, [this is a great resource](https://thenameless.net/astral-kit/anthropic-peit-00)


## Pre-Interview Setup

Before the interview, please run the following command to ensure your environment is properly set up:

```sh
# if the script doesn't run, first run   chmod +x setup_environment.sh
./setup_environment.sh
```

This script performs the following tasks:

1. Makes itself executable using `chmod +x`.
2. Checks if Node.js version 18 or newer is installed.
3. Verifies that `npx promptfoo@latest` can be run successfully.
4. Creates an alias `eval` for running `npx promptfoo@latest eval`.

The script ensures that your environment is properly configured for the interview session, including the necessary Node.js version, required tools, and API key setup.

After running the script, you'll be able to use the `eval` command as a shortcut for `npx promptfoo@latest eval` during the interview.


## Promptfoo

Your prompt engineering interview will be conducted using Promptfoo.

For more information about promptfoo and its usage, please visit the [official promptfoo documentation](https://promptfoo.dev/docs/).

Promptfoo is used primarily to test your prompting intuitions. You can use either js or python to do string extraction / assertion.
[Docs to python](https://www.promptfoo.dev/docs/configuration/expected-outputs/python/)
[Docs to javascript](https://www.promptfoo.dev/docs/configuration/expected-outputs/javascript)

## Starting the interview

```sh
# if the script doesn't run, first run   chmod +x start_interview.sh
./start_interview.sh
```

You'll be prompted with a password that your interviewer will provide. 

This script performs the following actions:

1. Checks if Node.js version 18 or newer is installed.
2. Verifies that `npx promptfoo@latest` can be run successfully.
3. Creates an alias `eval` for running `npx promptfoo@latest eval`.
4. Prompts you for the password provided by your interviewer.
5. Sends a request to our servers to verify the password and retrieve the OpenRouter API key (which will power your llm requests).
6. Sets the `OPENROUTER_API_KEY` environment variable with the retrieved key.

After running this script, you'll be ready to start the interview session with the necessary environment setup and API key in place.