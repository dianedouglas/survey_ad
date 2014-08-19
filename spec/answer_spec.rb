require 'spec_helper'

describe Answer do

  before do
    setup
  end

  it 'initializes an instance of a answer.' do
    expect(@test_answer).to be_an_instance_of Answer
  end

  it 'belongs to question' do
    expect(@test_answer.question).to eq @test_question
  end

end
