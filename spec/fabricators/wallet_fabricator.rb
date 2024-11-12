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
Fabricator(:wallet) do
  coins { 0 }
  user
end
