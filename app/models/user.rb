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
#  gender                 :string           default("male")
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
#  birthday               :date
#  auth_token             :string
#
# Indexes
#
#  index_users_on_auth_token            (auth_token) UNIQUE
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider              (provider)
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid                   (uid)
#

class User < ActiveRecord::Base
  paginates_per 3
  # enum gender: [:Male, :Female]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :twitter] 
  
  mount_uploader :photo, PhotoUploader 
  mount_uploader :video, VideoUploader

  GENDERS = [['Male', 'male'], ['Female', 'female']]

  with_options dependent: :destroy do |assoc|
    assoc.has_many :posts
    assoc.has_many :trips
    assoc.has_many :owned_groups, class_name: "Group"
    assoc.has_many :comments
    assoc.has_many :messages

  end
  
  has_and_belongs_to_many :conversations, uniq: true
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :joined_trips, class_name: "Trip"

  enum role: ['user', 'admin', 'moderator']
  ROLE = ['user', 'admin', 'moderator']

  
  validates :username, :first_name, :last_name, :email, presence: true
  validates :username, uniqueness: true  
  acts_as_followable
  acts_as_follower
  validates :gender, inclusion: { in: %w(male female), message: '%{value} is not a valid gender.' }

  before_save :ensure_authentication_token

  after_update :create_group

  def self.from_omniauth(auth)
    user = User.where("(provider = ? AND uid = ?) OR email = ? ", auth.provider, auth.uid, auth.info.email).first_or_initialize

    if !user.new_record?
      user.update_attributes(provider: auth.provider, uid: auth.uid, remote_photo_url: auth.info.image)
    else
      user.assign_attributes(
        email: auth.info.email,
        first_name: auth.info.name.split(" ", 2).first,
        last_name: auth.info.name.split(" ", 2).last,
        username: auth.info.nickname,
        remote_photo_url: auth.info.image,
        provider: auth.provider,
        uid: auth.uid
      )
    end

    user
  end

  def is_admin?
    role.eql? 'admin'
  end

  def is_user?
    role.eql? 'user'
  end

  def is_moderator?
    role.eql? 'moderator'
  end

  def is_administrator?
    ['admin', 'moderator'].include? self.role
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def create_from_omniauth(attributes)
    if attributes
      self.provider = attributes["provider"]
      self.uid = attributes["uid"]
    end
  end

  # authentication
  def ensure_authentication_token
    if auth_token.nil?
      self.auth_token = generate_auth_token
    end
  end

  def generate_auth_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(auth_token: token).first
    end
  end

  def create_group
    group_names = self.attributes.keep_if {|k, v| ["country", "city", "province", "neighborhood"]
      .include?(k) && !v.nil? && !v.blank? }

    admin = User.find_by(role: 1)

    group_names.each do |key, val|
      group = Group.where(name: val).first_or_initialize do |g|
        g.user_id = key.eql?('neighborhood') ? id : admin.id
        g.location = val
      end

      group.save(validate: false)

      group.users << self
    end
  end
end
