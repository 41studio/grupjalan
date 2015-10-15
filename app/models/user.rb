# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#  photo                  :string
#  username               :string
#  first_name             :string
#  last_name              :string
#  neighborhood           :string
#  address                :text
#  gender                 :string
#  brithday               :string
#  handphone              :string
#  status                 :string
#  video                  :string
#  country                :string
#  city                   :string
#  province               :string
#  role                   :integer          default(0)
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider              (provider)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid)
#

class User < ActiveRecord::Base
  # enum gender: [:Male, :Female]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter] 

  has_many :posts, dependent: :destroy
  has_many :trips, dependent: :destroy
  has_many :owned_groups, dependent: :destroy, class_name: "Group"
  has_and_belongs_to_many :groups
  enum role: ['user', 'admin', 'moderator']

  mount_uploader :photo, PhotoUploader 
  mount_uploader :video, VideoUploader 

  validates :username, :first_name, :last_name, :email, presence: true
  validates :username, uniqueness: true

  

  def is_admin?
    self.role.eql? 'admin'
  end


  def is_user?
    self.role.eql? 'user'
  end


  def is_moderator?
    self.role.eql? 'moderator'
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.from_facebook_omniauth(auth)
    user = User.where("(provider = ? AND uid = ?)  OR email = ? ", auth.provider, auth.uid, auth.info.email).first
    if user.present?
      user.update_attributes(provider: auth.provider, uid: auth.uid, remote_photo_url: auth.info.image)
    else
     user = User.new(
      email: auth.info.email,
      password:Devise.friendly_token[0,20],
      first_name: auth.info.first_name,
      username: Devise.friendly_token[0,20],
      last_name: auth.info.last_name,
      remote_photo_url: auth.info.image,
      provider: auth.provider,
      uid: auth.uid
      )
     # user = User.new(email: auth.info.email,password:Devise.friendly_token[0,20] , name:auth.info.name) 
     user.skip_confirmation!
     user.save
    end 
    user
  end

  def self.from_google_omniauth(auth)
    user = User.where("(provider = ? AND uid = ?)  OR email = ? ", auth.provider, auth.uid, auth.info.email).first
    if user.present?
      user.update_attributes(provider: auth.provider, uid: auth.uid, remote_photo_url: auth.info.image)
    else
     user = User.new(
      email: auth.info.email,
      password:Devise.friendly_token[0,20],
      first_name: auth.info.first_name,
      username: Devise.friendly_token[0,20],
      last_name: auth.info.last_name,
      provider: auth.provider,
      remote_photo_url: auth.info.image,
      uid: auth.uid
      )
     # user = User.new(email: auth.info.email,password:Devise.friendly_token[0,20] , name:auth.info.name) 
     user.skip_confirmation!
     user.save
    end 
    user
  end 

  def self.from_twitter_omniauth(auth)
    user = User.where("(provider = ? AND uid = ?)  OR email = ? ", auth.provider, auth.uid, auth.info.email).first
    if user.present?
      user.update_attributes(provider: auth.provider, uid: auth.uid, remote_photo_url: auth.info.image)
    else
     user = User.new(
      email: "#{Devise.friendly_token[0,20]}@email.com",
      password:Devise.friendly_token[0,20],
      first_name:auth.info.name.split.first,
      username: Devise.friendly_token[0,20],
      last_name: auth.info.name.split.last,
      provider: auth.provider,
      remote_photo_url: auth.info.image,
      uid: auth.uid
      )
     # user = User.new(email: auth.info.email,password:Devise.friendly_token[0,20] , name:auth.info.name) 
     user.skip_confirmation!
     user.save
    end 
    user
  end 
end
