require 'rails_helper'

RSpec.describe Wallet do
  context 'validations' do
    it 'is valid with valid attributes' do
      wallet = Fabricate.build(:wallet)
      expect(wallet).to be_valid
    end


  end
end