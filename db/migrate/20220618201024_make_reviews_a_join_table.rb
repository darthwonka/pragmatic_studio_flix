class MakeReviewsAJoinTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :email, :string
    add_column :reviews, :user_id, :integer
  end
end
