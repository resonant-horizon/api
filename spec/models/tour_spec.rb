require 'rails_helper'

describe Tour do
  describe 'relationships' do
    it { should belong_to :organization }
    it { should have_many :service_days }
    it { should have_many :tour_employees }
    it { should have_many(:employees).through(:tour_employees) }
    it { should have_many(:venues).through(:service_days) }
    it { should have_many(:contacts).through(:venues) }
    it { should have_many(:hotels).through(:service_days) }
    it { should have_many(:flights).through(:service_days) }
    it { should have_many(:passengers).through(:flights) }
  end

  describe 'validations' do
    it { should validate_presence_of :organization_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_date }
    it { should validate_presence_of :end_date }
  end
end
