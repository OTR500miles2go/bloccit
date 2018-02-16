require 'rails_helper'

RSpec.describe Question, type: :model do
  let(:post) { Question.create!(title: "New Question title", body: "New Question body", resolved: false ) }
  
  describe "attributes" do
    it "has title, body and resolved attributes" do
      expect(question).to have_attributes(title: "New Question title", body: "New Question body", resolved: false )
    end
  end  
end
