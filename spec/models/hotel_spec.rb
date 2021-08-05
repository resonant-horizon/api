require 'rails_helper'

describe Hotel do
  describe 'relationships' do
    it { should belong_to :organization }
    it { should have_many :service_hotels }
    it { should have_many(:service_days).through(:service_hotels) }
    it { should have_many(:tours).through(:service_days) }
    it { should have_many(:seasons).through(:service_days) }
    it { should have_many :contacts }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :country }
  end
end
