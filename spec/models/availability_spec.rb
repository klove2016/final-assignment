require 'rails_helper'

RSpec.describe Availability, type: :model do
    subject { Availability.new( title: "Test Availability",  start_time: Date.today,
    end_time: (Date.today + 1.day)  , user: FactoryBot.create(:user)) }
    
    describe "validations" do
    
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a title" do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without a start time" do
      subject.start_time = nil
      expect(subject).not_to be_valid
    end

    it "is not valid without an end time" do
      subject.end_time = nil
      expect(subject).not_to be_valid
    end

    it "is not valid if the start time is after the end time" do
        subject.start_time = "2023-03-01 "
        subject.end_time = "2023-02-27 "
        expect(subject).not_to be_valid
    end
  end
  
end
