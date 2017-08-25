module Support
  module JsonHelper
    def json
      JSON.parse(response.body, symbolize_names: true) rescue {}
    end
  end
end

RSpec.configure do |config|
  config.include Support::JsonHelper, type: :request
  config.include Support::JsonHelper, type: :controller
end
