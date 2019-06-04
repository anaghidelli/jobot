class Company < ApplicationRecord
  validates :name, presence: true
  has_many :jobs, dependent: :destroy
  has_many :company_industries, dependent: :destroy
  has_many :industries, through: :company_industries
  mount_uploader :logo, PhotoUploader
end
