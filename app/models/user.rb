# User Model
class User < ActiveRecord::Base
  has_many :trips
  has_many :comments
  has_secure_password validations: false

  validates :name, presence: true, unless: proc { |u| u.provider.present? }

  validates :email, presence: true, uniqueness: true,
  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
  unless: proc { |u| u.provider.present? }

  validates :password, presence: true, length: { minimum: 6 },
  unless: proc { |u| u.provider.present? }

  mount_uploader :image, ImageUploader

  def self.authenticate(email, password)
    user = find_by_email(email)
    bcrypt_password = BCrypt::Engine.hash_secret(password, user.password_digest)
    if user && user.password_digest == bcrypt_password
      user
    else
      nil
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.oauth_token = auth['oauth_token']
      user.name = auth['info']['name'] || '' if auth['info']
    end
  end
end
