# config/initializers/ruby_llm.rb
#
# Configures the ruby_llm gem to talk to Google Gemini via the free tier.
#
# The API key lives in:
#   - .env (development, gitignored — never commit this)
#   - Heroku config vars (production, set with `heroku config:set GEMINI_API_KEY=...`)
#
# Usage from anywhere in the app:
#
#   chat = RubyLLM.chat(model: "gemini-2.0-flash")
#   response = chat.ask("What's the sentiment around NVDA this week?")
#   puts response.content
#
# Models on the Gemini free tier (cheapest first):
#   - gemini-2.0-flash      (recommended default — fast, generous free tier)
#   - gemini-2.0-flash-lite (lightest)
#   - gemini-1.5-flash      (older but stable)
#
# See https://github.com/crmne/ruby_llm for full docs.

RubyLLM.configure do |config|
  config.openai_api_key = ENV["GITHUB_TOKEN"]
  config.openai_api_base = "https://models.inference.ai.azure.com"
  config.default_model = "gpt-4o-mini"
end
