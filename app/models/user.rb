class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true

  #belongs_to :books
  has_many :books
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  



  ##### follow/follwer ########

  # 自分がフォローしたり、アンフォローしたりするための記述
  # relationships, reverse_of_relationshipsは名前
  #class_name: "Relationship"でRelationshipテーブルを参照(参照先テーブル)
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy


  # throughはrelationships class_name "relationship"テーブルを通して
  # sourceというのは実際のカラム
  # 上のhasmanyの名前と合わせてみる。 
  # forgin_key 自分のid follwer_id を探してきて、それに紐づく followed_idを引っ張ってくる
  has_many :followings, through: :relationships, source: :followed   # 自分がフォローしている人すべての人を取得
  # forgin_key 自分のid followed_id を探してきて、それに紐づく follower_idを引っ張ってくる
  has_many :followers, through: :reverse_of_relationships, source: :follower # 自分のフォロワーすべての人を取得

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
