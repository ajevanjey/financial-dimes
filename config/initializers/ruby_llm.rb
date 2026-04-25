# config/initializers/ruby_llm.rb
#
# Configures the ruby_llm gem to talk to OpenAI models hosted on Azure,
# accessed for free via GitHub Models. Authentication uses a GitHub
# Personal Access Token (PAT) with the "Models: Read only" scope.
#
# The PAT lives in:
#   - .env (development, gitignored — never commit this)
#   - Heroku config vars (production, set with `heroku config:set GITHUB_TOKEN=...`)
#
# Usage from anywhere in the app:
#
#   chat = RubyLLM.chat               # uses the default model (gpt-4o-mini)
#   response = chat.ask("What's the sentiment around NVDA this week?")
#   puts response.content
#
# Optionally specify a model:
#
#   chat = RubyLLM.chat(model: "gpt-4o")
#
# How to get a token:
#   1. https://github.com/settings/tokens → Fine-grained tokens → Generate new token
#   2. No repo access needed
#   3. Account permissions → Models → Read only
#   4. Generate, copy, paste into .env
#
# See https://github.com/marketplace/models for available models.

RubyLLM.configure do |config|
  config.openai_api_key  = ENV.fetch("GITHUB_TOKEN", nil)
  config.openai_api_base = "https://models.inference.ai.azure.com"
  config.default_model   = "gpt-4o-mini"
end