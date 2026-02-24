# app/controllers/rails/pwa_controller.rb
class Rails::PwaController < ApplicationController
  def manifest
    render formats: [:webmanifest]
  end

  def service_worker
    render formats: [:js]
  end
end