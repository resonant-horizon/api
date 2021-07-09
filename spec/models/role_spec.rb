require 'rails_helper'

describe Role do
  describe 'relationships' do
    it { should have_many :employee_roles }
    it { should have_many(:employees).through(:employee_roles) }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end
end
