X402::Payments.configure do |config|
    config.default_pay_to = ENV['X402_PAY_TO']
    config.private_key = ENV['X402_PRIVATE_KEY']
    config.chain = Rails.env.production? ? 'base' : 'base-sepolia'
    
  # Optional: Override RPC URLs programmatically
  # config.rpc_urls = {
  #   'base' => 'https://your-custom-base-rpc.com',
  #   'base-sepolia' => 'https://your-sepolia-rpc.com'
  # }
end

