module Dashboard
  module AssistantSubmissionsHelper
    def status_color(status)
      case status.to_s.downcase
      when "pending"
        "warning"
      when "approved"
        "success"
      when "rejected"
        "danger"
      else
        "secondary"
      end
    end
  end
end
