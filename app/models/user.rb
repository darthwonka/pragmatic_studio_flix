class User < ApplicationRecord
  has_many :reviews, -> { order(create_date: :title) }
  
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, 
                    format: { with: /\S+@\S+/, message: "must be a valid email address like somebody@somedomain.com" },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6, allow_blank: true }
  # password have built in validation with the has_secure_password call. 

  def self.list
    @users = User.all
  end

   def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
   end

end

