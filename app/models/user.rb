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
