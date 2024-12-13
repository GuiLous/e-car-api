# frozen_string_literal: true

# == Schema Information
#
# Table name: purchases
#
#  id         :bigint           not null, primary key
#  price      :string           default("0"), not null
#  status     :integer          default("pending"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  price_id   :string
#  session_id :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_purchases_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_2888c5cba9  (user_id => users.id)
#
Fabricator(:purchase) do
  price_id { '1' }
  session_id { '1' }
  price { 0 }
  status { 0 }
  user { Fabricate :user }
end
