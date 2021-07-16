require 'rails_helper'

describe ServiceHotel do
  describe 'relationships' do
    it { should belong_to :service_day }
    it { should belong_to :hotel }
  end

  describe 'validations' do
    it { should validate_presence_of :hotel_id }
    it { should validate_presence_of :service_day_id }
  end
end
