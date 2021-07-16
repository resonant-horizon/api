require 'rails_helper'

describe Contact do
  describe 'relationships' do
    it { should belong_to :contactable }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :email }
    it { should validate_presence_of :description }
    it { should validate_presence_of :role }
    it { should validate_presence_of :is_permanent_party }
  end
end
