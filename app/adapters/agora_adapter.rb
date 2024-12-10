# frozen_string_literal: true

require "dynamic_key"

class AgoraAdapter
  include Singleton

  def generate_channel_credentials(channel_name: nil)
    app_id = ENV.fetch("AGORA_APP_ID")
    app_certificate = ENV.fetch("AGORA_APP_CERTIFICATE")
    channel_name ||= generate_channel_name
    uid = uid32
    token_expiration_in_seconds = 24 * 3600 # 24 hours in seconds

    params = {
      app_id: app_id,
      app_certificate: app_certificate,
      channel_name: channel_name,
      uid: uid,
      role: AgoraDynamicKey::RTCTokenBuilder::Role::PUBLISHER,
      privilege_expired_ts: Time.now.to_i + token_expiration_in_seconds
    }

    token = AgoraDynamicKey::RTCTokenBuilder.build_token_with_uid params

    {
      channel: channel_name,
      token: token,
      uid: uid
    }
  end

  def generate_channel_name
    "channel_#{Time.now.to_i}_#{SecureRandom.hex(4)}"
  end

  def uid32
    rand(1...(2**32))
  end
end
