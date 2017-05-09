ENV['RACK_ENV'] = 'test'

require("rspec")
require("pg")
require("sinatra/activerecord")
require("answer")
require("question")

RSpec.configure do |config|
  config.after(:each) do
    Answer.all().each() do |answer|
      answer.destroy()
    end
  end
end
