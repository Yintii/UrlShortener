class ShortLinksController < ApplicationController
  rate_limit to: 50, within: 1.minute, only: :home,
    by: -> { request.domain },
    with: -> { redirect_to root_path, alert: "Too many requests, try again in 10 minutes." }

  def home
    if request.post?

      if params[:link].blank?
        flash[:error] = "You must enter a link to shorten"
        redirect_to root_path
        return
      end

      if params[:action_type] == "qr"
        handle_qr_code
      else
        handle_short_link
      end

    elsif request.get?
      if params[:created_qr_code]
        record = ShortLink.find_by(short_link: params[:created_qr_code], link_type: "qr")
        @qr_code = record&.qr_code_data
      elsif params[:short_link]
        handle_redirect
      end
    end
  end

  private

  def handle_qr_code
    require "rqrcode"
  
    short_code = SecureRandom.hex(3)
    db_entry = ShortLink.new(
      original_link: params[:link],
      short_link: short_code,
      link_type: "qr"
    )
    db_entry.user = current_user if user_signed_in?
  
    if db_entry.valid?
      begin
        qrcode = RQRCode::QRCode.new(params[:link])
        svg = qrcode.as_svg(
          color: "000",
          shape_rendering: "crispEdges",
          module_size: 4,
          standalone: true,
          use_path: true
        )
        db_entry.qr_code_data = svg
        db_entry.save
        ActiveRecord::Base.connection.close
        flash[:success] = "QR Code generated successfully!"
        redirect_to root_path(created_qr_code: short_code)
      rescue ActiveRecord::RecordNotUnique
        retry
      end
    else
      flash[:error] = "Error generating QR code"
    end
  end

  def handle_short_link
    short_link = SecureRandom.hex(3)
    db_entry = ShortLink.new(
      original_link: params[:link],
      short_link: short_link,
      link_type: "shrtn"
    )
    db_entry.user = current_user if user_signed_in?

    if db_entry.valid?
      begin
        db_entry.save
        ActiveRecord::Base.connection.close
        flash[:success] = "Link shortened successfully!"
        redirect_to root_path(created_short_link: short_link)
        return
      rescue ActiveRecord::RecordNotUnique
        short_link = SecureRandom.hex(3)
        db_entry.short_link = short_link
        retry
      end
    else
      flash[:error] = "Error creating short link"
    end
  end

  def handle_redirect
    short_link = ShortLink.find_by(short_link: params[:short_link])

    if short_link.nil?
      flash[:error] = "The link you entered does not exist"
      redirect_to root_path
      return
    end

    short_link.record_click!(
      ip_address: request.remote_ip,
      referrer: request.referrer,
      user_agent: request.user_agent
    )
    ActiveRecord::Base.connection.close

    # QR codes track the click but still redirect to the original link
    redirect_short_link(short_link)
  end

  def redirect_short_link(short_link)
    target = short_link.original_link
    uri = URI.parse(target)
    unless uri.is_a?(URI::HTTP) && uri.host.present?
      return render plain: "Invalid redirect target", status: :unprocessable_entity
    end
    redirect_to target, status: :moved_permanently, allow_other_host: true
  rescue URI::InvalidURIError
    render plain: "Invalid redirect target", status: :unprocessable_entity
  end
end