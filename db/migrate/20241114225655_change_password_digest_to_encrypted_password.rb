# frozen_string_literal: true

class ChangePasswordDigestToEncryptedPassword < ActiveRecord::Migration[7.2]
  def change
    rename_column :users, :password_digest, :encrypted_password
  end
end
