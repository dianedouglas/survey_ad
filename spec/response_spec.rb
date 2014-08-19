require 'spec_helper'

describe Response do

  before do
    setup
  end

  it 'initializes an instance of a response.' do
    expect(@test_response).to be_an_instance_of Response
  end

  it 'belongs to a question' do
    expect(@test_question.responses).to eq [@test_response]
  end

end
