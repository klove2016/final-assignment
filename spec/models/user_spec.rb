require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'John Doe', email: 'john.doe@example.com', phone: '1234567890') }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without an email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a phone number' do
      subject.phone = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid with a duplicate email' do
      user = User.new(name: 'Jane Doe', email: 'john.doe@example.com', phone: '0987654321')
      subject.save
      expect(user).to_not be_valid
    end

    it 'is not valid with an invalid email format' do
      subject.email = 'not_an_email'
      expect(subject).to_not be_valid
    end

    it 'is not valid with an invalid phone number format' do
      subject.phone = 'not_a_phone'
      expect(subject).to_not be_valid
    end
  end
end

