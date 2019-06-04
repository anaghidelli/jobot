class Industry < ApplicationRecord
  has_many :user_industries, dependent: :destroy
  has_many :users, through: :user_industries
  has_many :company_industries, dependent: :destroy
  has_many :companies, through: :company_industries
end
