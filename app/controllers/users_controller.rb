class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile]
  
  def profile
    @user = current_user
    @short_links = @user.short_links
  end

  def qr_download
    record = ShortLink.find_by(short_link: params[:short_code], link_type: "qr")
    return redirect_to root_path if record.nil?
  
    qrcode = RQRCode::QRCode.new(record.original_link)
    png = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_orth: false,
      size: 300
    )
  
    send_data png.to_blob,
      filename: 'qr_code.png',
      type: 'image/png',
      disposition: 'attachment'
  end 
end
