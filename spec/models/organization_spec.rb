require 'rails_helper'

describe Organization do
  describe 'relationships' do
    it { should belong_to :user }
    it { should have_many :employees }
    # it { should have_many :seasons }
    # it { should have_many :tours }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :contact_name }
    it { should validate_presence_of :contact_email }
    it { should validate_presence_of :phone_number }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :user_id }
  end
end
