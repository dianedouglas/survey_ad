require 'pg'
require 'active_record'
require 'rspec'
require 'survey'
require "question"
require "answer"

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configuration = database_configurations['test']
ActiveRecord::Base.establish_connection(development_configuration)

RSpec.configure do |config|
  config.after(:each) do
    Survey.all.each{|survey| survey.destroy}
  end
end

def setup
  @test_survey = Survey.create({ name: 'what ancient greek goddess are you?' })
  @test_question = Question.create({ name: 'Where would you feel most at home?', survey_id: @test_survey.id })
  @test_answer = Answer.create({ name: 'In a big cosmopolitian city, bathed in culture!', question_id: @test_question.id })
end
