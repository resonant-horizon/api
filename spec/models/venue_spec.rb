require 'rails_helper'

describe Venue do
  describe 'relationships' do
    it { should have_many :service_venues }
    it { should have_many(:service_days).through(:service_venues) }
    it { should have_many :contacts }
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }


    # stage width, depth, heighth, total square feet, lighting,


  end

end
