class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  #ログイン時に必須のため
  validates :nickname, presence: true

  has_many :readings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :nices, dependent: :destroy

  # follow用
  has_many :follows, dependent: :destroy
  #through: :relationships 「中間テーブルはrelationships」設定
  #source: :follow　relationshipsテーブルのfollow_idを参考にして、followingsモデルにアクセス」
  #user.followings と打つだけで、user が中間テーブル relationships を取得し、その1つ1つの relationship のfollow_idから、「フォローしている User 達」を取得しています
  has_many :followings, through: :relationships, source: :follow

  #フォロワー（フォローされているuser達）をとってくるための記述
  #has_many :relaitonshipsの「逆方向」意味
  #foreign_key: 'follow_id' elaitonshipsテーブルにアクセスする時、follow_idを入口」
  has_many :reverse_of_follows, class_name: 'follows', foreign_key: 'follow_id'
  #through: :reverses_of_relationshipで「中間テーブルはreverses_of_relationship」
  #source: :userで「出口はuser_idね！それでuserテーブルから自分をフォローしているuserをとってきてね！」と設定
  has_many :followers, through: :reverse_of_follows, source: :user
end
