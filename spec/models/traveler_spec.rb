require 'rails_helper'

describe Traveler do
  describe 'relationships' do
    it { should belong_to :employee }
  end

  describe 'validations' do
    it { should validate_presence_of :employee_id }
    it { should validate_presence_of :seat_preference }
  end
end
