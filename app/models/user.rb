class User < ApplicationRecord
  before_save { self.email = email.downcase if email.present? }
  before_save :format_name

  validates :name, length: { minimum: 1, maximum: 100}, presence: true

  validates :password, presence: true, length: {minimum: 6}, if: "password_digest.nil?"
  validates :password, length: {minimum: 6}, allow_blank: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false},
            length: { minimum: 3, maximum: 254}

  has_secure_password

  def format_name
    if name
      split_name = []
      split_name = name.split
        for item in split_name do
          item.capitalize!
        end
        self.name = split_name.join(" ")
    end
  end

end