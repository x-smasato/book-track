require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'is not valid without a name' do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end

    it 'is not valid with an empty name' do
      user = build(:user, name: '')
      expect(user).not_to be_valid
    end

    it 'is valid with an empty description' do
      user = build(:user, description: '')
      expect(user).to be_valid
    end
  end
end
