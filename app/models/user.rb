# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string           default(""), not null
#  encrypted_password         :string           default(""), not null
#  reset_password_token       :string
#  reset_password_sent_at     :datetime
#  remember_created_at        :datetime
#  first_name                 :string
#  last_name                  :string
#  announcements_last_read_at :datetime
#  admin                      :boolean          default(FALSE)
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  little_description         :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :masqueradable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable
  has_rich_text :little_description
  has_person_name
  acts_as_voter
  acts_as_followable
  acts_as_follower
  has_many :notifications, foreign_key: :recipient_id
  has_many :services
  has_many :gifs , dependent: :destroy
  validates :name , presence: true
  validates :email, presence: true, 'valid_email_2/email': true
  
end
