require 'rails_helper'

describe TourEmployee do
  describe 'relationships' do
    it { should belong_to :tour }
    it { should belong_to :employee }
  end

  describe 'validations' do
    it { should validate_presence_of :tour_id }
    it { should validate_presence_of :employee_id }
  end
end
