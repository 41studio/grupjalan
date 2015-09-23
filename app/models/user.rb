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


  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create(email: auth.info.email,password:Devise.friendly_token[0,20])

    # where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #   user.email = auth.provider.eql? "facebook" ? auth.info.email : "#{auth.uid}@kris.com"
    #   user.password = Devise.friendly_token[0,20]
    #   user.name = auth.info.name
    # end 
  end

  # def self.find_for_facebook_oauth(auth)
  #   if user = User.where(:provider => auth.provider, :uid => auth.uid).first
  #     return user
  #   else
  #     if User.where(email: auth.info.email).exists?
  #       user = User.where(email: auth.info.email).first
  #       user.provider = auth.provider
  #       user.uid = auth.uid
  #       if !user.confirmed?
  #         user.skip_confirmation!
  #       end
  #       return user
  #     else
  #       if auth.info.email.present?
  #         user = User.new(provider: auth.provider,    
  #                         uid: auth.uid,
  #                         email: auth.info.email,
  #                         password: Devise.friendly_token[0,20])
  #         user.skip_confirmation!
  #         user.create_profile(name: auth.info.first_name, lastname: auth.info.last_name, username: auth.info.nickname,
  #                             birthday: Date.strptime(auth.extra.raw_info.birthday,'%m/%d/%Y'), gender: auth.extra.raw_info.gender)
  #         user.save
  #         return user
  #       end
  #     end
  #   end
  # end

#   def self.from_omniauth(auth)
#    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
#    user.email = auth.info.email.present? ? auth.info.email : "#{auth.info.first_name}#{auth.info.last_name}@mail.com"
#    user.password = Devise.friendly_token[0,20]
#    user.name = auth.info.name   # assuming the user model has a name
#    user.remote_avatar_url = auth.info.image # assuming the user model has an image
#    user.save
#  end
# end


  def self.from_omniauth(auth)
    user = User.where("(provider = ? AND uid = ?)  OR email = ? ", auth.provider, auth.uid, auth.info.email).first
    if user.present?
      user.update_attributes(provider: auth.provider, uid: auth.uid)
    else
     user = User.new(email: auth.info.email,password:Devise.friendly_token[0,20])
     # user = User.new(email: auth.info.email,password:Devise.friendly_token[0,20] , name:auth.info.name) 
     user.save
    end 
    user
  end 


  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end     
  end  
end
