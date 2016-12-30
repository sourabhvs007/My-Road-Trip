module ConfigCenter
  module Default

    def self.host
      case Rails.env
      when "development"
        'http://localhost:3000'
      end
    end


    def self.fog_directory
      case Rails.env
        #Todo change this name to loanlist-development
      when "development"
        'rvidi-it-thumbnail'
      end
    end
  end
end