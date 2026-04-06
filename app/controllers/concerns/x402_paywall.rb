module X402Paywall
  extend ActiveSupport::Concern

  FACILITATOR_URL = "https://X402.org/facilitator"

  included do
    before_action :verify_X402_payment, if: :X402_protected?
  end

  private

  # Override this in your controller to enable protection
  def X402_protected?
    false
  end

  def verify_X402_payment
    payment_header = request.headers["PAYMENT-SIGNATURE"]

    if payment_header.blank?
      render_402_required and return
    end

    result = call_facilitator(payment_header)

    unless result[:valid]
      render json: { error: "Payment invalid or insufficient" }, status: :payment_required
    end
  end

  def render_402_required
    payment_requirements = {
      version: "2",
      scheme: "exact",
      network: "eip155:#{chain_id}",
      maxAmountRequired: usdc_atomic(X402_price),
      resource: request.original_url,
      description: X402_description,
      mimeType: "application/json",
      payTo: ENV["X402_PAY_TO"],
      maxTimeoutSeconds: 600,
      asset: usdc_contract_address,
      extra: { name: "USD Coin", version: "2" }
    }

    response.headers["PAYMENT-REQUIRED"] =
      Base64.strict_encode64(payment_requirements.to_json)

    render json: payment_requirements, status: :payment_required
  end

  def call_facilitator(payment_header)
    uri = URI("#{FACILITATOR_URL}/verify")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    req = Net::HTTP::Post.new(uri.path, "Content-Type" => "application/json")
    req.body = {
      paymentHeader: payment_header,
      requirements: {
        network: "eip155:#{chain_id}",
        maxAmountRequired: usdc_atomic(X402_price),
        resource: request.original_url,
        payTo: ENV["X402_PAY_TO"],
        asset: usdc_contract_address
      }
    }.to_json

    response = http.request(req)
    JSON.parse(response.body, symbolize_names: true)
  rescue => e
    Rails.logger.error("X402 facilitator error: #{e.message}")
    { valid: false }
  end

  # Helpers — override these per controller as needed
  def X402_price
    0.001  # USD
  end

  def X402_description
    "Payment required"
  end

  def chain_id
    #Rails.env.production? ? "8453" : 
    "84532"  # base / base-sepolia
  end

  def usdc_atomic(usd_amount)
    (usd_amount * 1_000_000).to_i.to_s  # USDC has 6 decimals
  end

  def usdc_contract_address
    Rails.env.production? \
      ? "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913"   # Base USDC
      : "0x036CbD53842c5426634e7929541eC2318f3dCF7e"   # Base Sepolia USDC
  end
end