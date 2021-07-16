require 'rails_helper'

describe EventEmployee do
  describe 'relationships' do
    it { should belong_to :employee }
    it { should belong_to :event }
  end

  describe 'validations' do
    it { should validate_presence_of :employee_id }
    it { should validate_presence_of :event_id }
  end
end
