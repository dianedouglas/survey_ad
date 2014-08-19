require 'active_record'
require './lib/answer'
require './lib/survey'
require './lib/question'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configurations = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configurations)

@current_survey = nil

def main_menu
  puts "\n\n"
  puts "Welcome to the Survey program\n\n"

    puts "Enter 'sd' if you are a survey designer."
    puts "Enter 'st' if you are a survey taker."
    user_input = gets.chomp

    if user_input == 'sd'
      designer_menu
    elsif user_input == 'st'
      taker_menu
    else
      puts "Invalid input, please try again."
      main_menu
    end

end

def designer_menu
  puts "\n\n"
  puts "Enter 'ns' to design a new survey."
  puts "Enter 'm' to return to the main menu."
  puts "Enter 'es' to edit an existing survey."
  choice = gets.chomp
  if choice == 'ns'
    new_survey
  elsif choice == 'm'
    main_menu
  else
    puts "Try, try again!"
    designer_menu
  end
end

def new_survey
  puts "\n\n"
  puts "What would you like to call your survey?"
  survey_name = gets.chomp

  @current_survey = Survey.create({ name: survey_name })
  print_all_surveys
  choice = nil
  until choice == 'n'
    puts "Would you like to a add question to your survey? (y/n)"
    choice = gets.chomp

    case choice
    when 'y'
      add_question
    else
      if choice != 'n'
      puts "You fail, go away!"
      end
    end
  end
  puts "Here is your survey #{@current_survey.name}"
  print_survey_questions
end

def print_all_surveys
  puts "\n\n"
  puts "Here are all the current surveys:"
  Survey.all.each_with_index do |survey, index|
    puts (index + 1).to_s + ' ' + survey.name
  end
  puts "\n\n"
end

def print_survey_questions
  puts "\n\n"
  puts "Here are all the current questions:"
  @current_survey.questions.each_with_index do |question, index|
      puts (index + 1).to_s + ' ' + question.name
    end
  puts "\n\n"
end

def add_question
  puts "\n\n"
  puts "What is your question?"
  user_input = gets.chomp
  @current_survey.questions.create({ name: user_input })
end

def taker_menu
end

main_menu
