class X402Service 
    def self.generate_payment_for(resource_url, amount: 0.001)
        X402::Payments.generate_header(
            amount: amount,
            resource: resource_url,
            description: "Payment for #{resource_url}"
        )
    end
end