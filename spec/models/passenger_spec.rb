require 'rails_helper'

describe Passenger do
  describe 'relationships' do
    it { should belong_to :employee }
    it { should belong_to :flight }
  end

  describe 'validations' do
    it { should validate_presence_of :employee_id }
    it { should validate_presence_of :flight_id }
  end
end
