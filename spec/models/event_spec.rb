require 'rails_helper'

describe Event do
  describe 'relationships' do
    it { should belong_to :service_day }
    it { should have_many :event_employees }
    it { should have_many(:employees).through(:event_employees) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :service_day_id }
  end
end
