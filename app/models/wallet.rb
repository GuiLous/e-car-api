# frozen_string_literal: true

# == Schema Information
#
# Table name: wallets
#
#  id         :bigint           not null, primary key
#  coins      :integer          default(0), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_wallets_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_732f6628c4  (user_id => users.id)
#
class Wallet < ApplicationRecord
  belongs_to :user

  def add_coins(amount)
    update!(coins: coins + amount)
  end

  def remove_coins(amount)
    update!(coins: coins - amount)
  end

  def blocked_coins
    user.hired_services.where(status: %w[scheduled analyzing]).joins(:assistant_service).sum("assistant_services.price")
  end

  def available_coins
    coins - blocked_coins
  end
end
