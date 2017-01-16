OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
 provider :facebook, (ENV['FB_APP_ID'] || '1569067850011644'),
 (ENV['FB_APP_SECRET'] || '31f924f80e9f61e255c8b1a1d9a9f016'), :strategy_class =>
 OmniAuth::Strategies::Facebook
end