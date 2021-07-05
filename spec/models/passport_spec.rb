require 'rails_helper'

describe Passport do
  describe 'relationships' do
    it { should belong_to :employee }
  end

  describe 'validations' do
    it { should validate_presence_of :passport_number }
    it { should validate_presence_of :surname }
    it { should validate_presence_of :given_names }
    it { should validate_presence_of :nationality }
    it { should validate_presence_of :birth_place }
    it { should validate_presence_of :birthdate }
    it { should validate_presence_of :expiration_date }
    it { should validate_presence_of :issue_date }
    it { should validate_presence_of :passport_sex }
    it { should validate_presence_of :employee_id }
  end
end
