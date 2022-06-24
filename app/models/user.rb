class User < ApplicationRecord
  has_many :reviews, dependent: :destroy 
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_secure_password

  validates :username, presence: true,
            format: { with: /\A[A-Z0-9]+\z/i },
            uniqueness: { case_sensitive: false }
  validates :name, presence: true
  validates :email, presence: true, 
                    format: { with: /\S+@\S+/, message: "must be a valid email address like somebody@somedomain.com" },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }
  # password have built in validation with the has_secure_password call. 

  scope :by_name, -> { order(:name)}
  scope :admins, -> { by_name.where("admin = true")}
  scope :not_admin, -> { by_name.where("admin = false")}

   def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
   end

   def to_param
      username
   end

end

