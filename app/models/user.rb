class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[linkedin]
  has_many :user_industries
  has_many :industries, through: :user_industries
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :saved_jobs
  has_many :jobs, through: :saved_jobs
  has_many :user_languages
  has_many :languages, through: :user_languages

# class User < ApplicationRecord
#   def self.new_with_session(params, session)
#     super.tap do |user|
#       if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
#         user.email = data["email"] if user.email.blank?
#       end
#     end
#   end
# end

def self.from_omniauth(auth)
  binding.pry
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name   # assuming the user model has a name
    # user.image = auth.info.image # assuming the user model has an image
    # If you are using confirmable and the provider(s) you use validate emails,
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end
end

  # devise :omniauthable, omniauth_providers: [:linkedin]

  # def self.find_for_linkedin_oauth(auth)
  #   user_params = auth.to_h.slice("provider", "uid")
  #   user_params.merge! auth.info.slice(:first_name, :last_name, :email)
  #   # user_params[:location_name] = auth.extra.raw_info.location.name

  #   user_params[:linkedin_profile_url] = auth.info.urls.public_profile
  #   user_params[:linkedin_picture_url] = auth.info.image

  #   user = User.where(provider: auth.provider, uid: auth.uid).first
  #   user ||= User.where(email: auth.info.email).first

  #   if user
  #     user.update(user_params)
  #   else
  #     user = User.new(user_params)
  #     user.password = Devise.friendly_token[0, 20]
  #     user.save
  #   end

  #   return user
  # end

  # def fullname
  #   return self.first_name + " " + self.last_name
  # end
end


