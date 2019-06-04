class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :destroy_12_hours
  before_action :destroy_72_hours

  def destroy_12_hours
    GuestUser.all.each do |gu|
      gu.destroy if gu.created_at < Time.now - 12.hours
    end
  end

  def destroy_72_hours
    Job.all.each do |j|
      j.destroy if j.created_at < Time.now - 72.hours
    end
  end

  def after_sign_in_path_for(resource)
    jobs_path
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end

end
