require 'rails_helper'

describe Employee do
  describe 'relationships' do
    it { should belong_to :organization }
    it { should belong_to :user }
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
    it { should validate_presence_of :union_designee }
    it { should validate_presence_of :employment_status }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :organization_id }
  end
end
