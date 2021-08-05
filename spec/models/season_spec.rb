require 'rails_helper'

describe Season do
  describe 'relationships' do
    it { should belong_to :organization }
    it { should have_many :service_days }
    it { should have_many(:employees).through(:season_employees) }
    it { should have_many(:venues).through(:service_days) }
    it { should have_many(:hotels).through(:service_days) }
    it { should have_many(:contacts).through(:venues) }
  end

  describe 'validations' do
    it { should validate_presence_of :organization_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end
end
