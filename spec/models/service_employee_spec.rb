require 'rails_helper'

describe ServiceEmployee do
  describe 'relationships' do
    it { should belong_to :service_day }
    it { should belong_to :employee }
  end

  describe 'validations' do
    it { should validate_presence_of :service_day_id }
    it { should validate_presence_of :employee_id }
  end
end
