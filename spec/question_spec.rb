require 'spec_helper'

describe Question do

  before do
    setup
  end

  it 'initializes an instance of a question.' do
    expect(@test_question).to be_an_instance_of Question
  end

  it 'has many answers' do
    expect(@test_question.answers).to eq [@test_answer]
  end

end
