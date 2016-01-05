# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  subject    :string
#  message    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Contact < ActiveRecord::Base
  belongs_to :user

  validates :name, length: { maximum: 225 }
  validates :email, length: { maximum: 225}
  validates :subject, length: { maximum: 225}
  validates :message, length: { maximum: 1000}
  CAT = ['Pesan', 'Laporan Bug', 'Lainnya']
end
