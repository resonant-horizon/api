require 'rails_helper'

describe SeasonEmployee do
  describe 'relationships' do
    it { should belong_to :season }
    it { should belong_to :employee }
  end

  describe 'validations' do
    it { should validate_presence_of :season_id }
    it { should validate_presence_of :employee_id }
  end
end
