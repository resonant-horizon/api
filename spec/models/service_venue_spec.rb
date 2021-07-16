require 'rails_helper'

describe ServiceVenue do
  describe 'relationships' do
    it { should belong_to :venue }
    it { should belong_to :service_day }
  end

  describe 'validations' do
    it { should validate_presence_of :venue_id }
    it { should validate_presence_of :service_day_id }
  end
end
