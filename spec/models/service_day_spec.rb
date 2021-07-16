require 'rails_helper'

describe ServiceDay do
  describe 'relationships' do
    it { should belong_to :workable }
    it { should have_many :service_venues }
    it { should have_many(:venues).through(:service_venues) }
    it { should have_many(:contacts).through(:venues) }
    it { should have_many :service_hotels }
    it { should have_many(:hotels).through(:service_hotels) }
    it { should have_many :events }
    it { should have_many :service_employees }
    it { should have_many(:employees).through(:service_employees) }
    # it { should have_one(:after_action_review)}
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :date }
    # it { should validate that date falls within season/tour dates}
    it { should validate_presence_of :has_travel }
    it { should validate_presence_of :has_rehearsal }
    it { should validate_presence_of :has_concert }
    it { should validate_presence_of :has_loadin }
    it { should validate_presence_of :has_loadout }
    it { should validate_presence_of :workable_id }
  end
end
