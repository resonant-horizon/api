require 'rails_helper'

describe Contact do
  describe 'relationships' do
    it { should belong_to :contactable }
    it { should belong_to :organization }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :email }
    it { should validate_presence_of :organization_id }
  end
end
