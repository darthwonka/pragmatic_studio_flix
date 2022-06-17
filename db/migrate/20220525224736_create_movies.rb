class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :rating
      t.decimal :total_gross
      t.datetime :released_on
      t.text :description
      t.timestamps
    end
  end
end
