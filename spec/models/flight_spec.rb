require 'rails_helper'

describe Flight do
  describe 'relationships' do
    it { should belong_to :service_day }
    it { should have_many :passengers }
    it { should have_many(:employees).through(:passengers) }
  end

  describe 'validations' do
    it { should validate_presence_of :airline_network }
    it { should validate_presence_of :airline }
    it { should validate_presence_of :flight_number }
    it { should validate_presence_of :departure_time }
    it { should validate_presence_of :arrival_time }
    it { should validate_presence_of :departure_airport }
    it { should validate_presence_of :arrival_airport }
    it { should validate_presence_of :is_international }
    it { should validate_presence_of :service_day_id }
  end
end
