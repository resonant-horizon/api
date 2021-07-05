require 'rails_helper'

describe Employee do
  describe 'relationships' do
    it { should belong_to :organization }
    it { should belong_to :user }
  end

  describe 'validations' do
    it { should validate_presence_of :union_designee }
    it { should validate_presence_of :employment_status }
    it { should validate_presence_of :instrument_section }
    it { should validate_presence_of :role }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :organization_id }
  end
end
