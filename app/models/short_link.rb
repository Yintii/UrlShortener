class ShortLink < ApplicationRecord
  belongs_to :user, optional: true
end
