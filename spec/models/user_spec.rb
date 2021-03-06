require 'rails_helper'

describe User do
  describe 'setting token' do
    it 'ensures unique token' do
      existing_token = 'abc123'
      new_token = 'def456'

      existing_user = FactoryBot.create :user

      # rubocop:disable Rails/SkipsModelValidations
      existing_user.update_attribute :token, existing_token.upcase
      # rubocop:enable Rails/SkipsModelValidations

      allow(SecureRandom).to receive(:hex).and_return(existing_token, new_token)

      user = FactoryBot.create :user
      expect(user.token).to eq new_token.upcase
    end
  end
end
