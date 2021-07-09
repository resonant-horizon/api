require 'rails_helper'

describe EmployeeRole do
  describe 'relationships' do
    it { should belong_to :employee }
    it { should belong_to :role }
  end

  describe 'validations' do
    it { should validate_presence_of :employee_id }
    it { should validate_presence_of :role_id }
  end
end
