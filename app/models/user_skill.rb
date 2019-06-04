class UserSkill < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :guest_user, optional: true
  belongs_to :skill
end
