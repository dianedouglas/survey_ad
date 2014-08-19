require 'active_record'
require './lib/answer'
require './lib/survey'
require './lib/question'
require './lib/response'
require 'pry'

database_configurations = YAML::load(File.open('./db/config.yml'))
development_configurations = database_configurations['development']
ActiveRecord::Base.establish_connection(development_configurations)

@current_survey = nil
@current_question = nil


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
  puts "Enter 'p' to view percentage survey statistics."

  choice = gets.chomp
  if choice == 'ns'
    new_survey
  elsif choice == 'm'
    main_menu
  elsif choice == 'p'
    percentage
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
  @current_question = @current_survey.questions.create({ name: user_input })
  puts "Add possible responses"
  possible_responses
end

def possible_responses
  puts "\n\n"
  answer = nil
  loop do
  puts "Enter a user question option and when finished enter 'done'"
    answer = gets.chomp
    if answer == 'done'
      break
    else
    @current_question.answers.create({ name: answer })
    end
  end
  puts @current_question.name
  print_possible_responses
end

def print_questions_one_by_one
  @current_survey.questions.each do |query|
    puts "\n\n"
    puts query.name
    @current_question = query
    print_possible_responses
    loop do
    puts "Please enter the number of your answer:"
    answer = gets.chomp.to_i
      if (answer.is_a? Fixnum) && (answer > 0) && (answer <= @current_question.answers.length)
        @current_question.responses.create({ answer_id: answer})
        break
      else
        puts "You done goofed. That wasn't a response."
      end
    end
  end
end

def print_possible_responses
  puts "\n\n"
  @current_question.answers.each_with_index do |answer, index|
    puts (index + 1).to_s + ' ' + answer.name
  end
end

def taker_menu
  print_all_surveys
  puts "Please enter the survey name you would like to take."
  taker_response = gets.chomp
  @current_survey = nil
  Survey.all.each do |survey|
    if taker_response == survey.name
      @current_survey = survey
      break
    end
  end
  if @current_survey == nil
    puts "Errrrr You SUCK"
  else
    print_questions_one_by_one
  end
end

def percentage
  print_all_surveys
  puts "Please enter the survey name you would like to view."
  view_response = gets.chomp
  @current_survey = nil
  Survey.all.each do |survey|
    if view_response == survey.name
      @current_survey = survey
      break
    end
  end
  number_of_people = @current_survey.questions[0].responses.length
  puts "#{number_of_people} people took this survey."
  @current_survey.questions.each_with_index do |quest, i|
    people_who_chose1 = @current_survey.questions[i].responses.where({answer_id: 1}).count
  end
  puts "people who chose 1: #{people_who_chose1}"
end

main_menu
