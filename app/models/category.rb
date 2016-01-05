# == Schema Information
#
# Table name: categories
#
#  id            :integer          not null, primary key
#  plan_category :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Category < ActiveRecord::Base
	has_many :groups, dependent: :destroy
  CAT = ['Pesan', 'Laporan Bug', 'Lainnya']
end
