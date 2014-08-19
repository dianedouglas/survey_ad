require 'spec_helper'

describe Survey do
  before do
    setup
  end
  it 'initializes an instance of a survey.' do
    expect(@test_survey).to be_an_instance_of Survey
  end
end
