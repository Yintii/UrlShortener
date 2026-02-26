module ApplicationHelper
  def gravatar_image_tag(email, options = {})
    hash = Digest::MD5.hexdigest(email.to_s.downcase.strip)
    size = options.delete(:size) || 80
    alt  = options.delete(:alt) || email
    secure = options.dig(:gravatar, :secure) != false

    base = secure ? "https://secure.gravatar.com" : "http://www.gravatar.com"
    url  = "#{base}/avatar/#{hash}?s=#{size}"

    image_tag(url, alt: alt, **options.except(:gravatar))
  end
end