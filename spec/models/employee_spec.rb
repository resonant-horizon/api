require 'rails_helper'

describe Employee do
  describe 'relationships' do
    it { should belong_to :organization }
    it { should belong_to :user }
    it { should have_one :passport }
    it { should have_one :biography }
    it { should have_one :traveler }
    it { should have_many(:employee_roles) }
    it { should have_many(:roles).through(:employee_roles) }
    it { should have_many(:season_employees) }
    it { should have_many(:seasons).through(:season_employees) }
    it { should have_many :tour_employees }
    it { should have_many(:tours).through(:tour_employees) }
    it { should have_many :event_employees }
    it { should have_many(:service_days).through(:service_employees) }
    it { should have_many :event_employees }
    it { should have_many(:events).through(:event_employees) }
    it { should have_many :passengers }
    it { should have_many(:flights).through(:passengers) }
  end

  describe 'validations' do
    it { should validate_presence_of :employment_status }
    it { should validate_presence_of :instrument_section }
    it { should validate_presence_of :user_id }
    it { should validate_presence_of :organization_id }
  end
end
