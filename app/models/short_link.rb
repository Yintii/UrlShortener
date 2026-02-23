class ShortLink < ApplicationRecord
  belongs_to :user, optional: true
  
  def record_click!
      increment!(:click_count)
  end
end
