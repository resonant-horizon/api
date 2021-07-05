require 'rails_helper'

describe Biography do
  describe 'relationships' do
    it { should belong_to :employee }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :email }
    it { should validate_presence_of :full_legal_name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :ssn }
    it { should validate_presence_of :employee_id }
  end
end
