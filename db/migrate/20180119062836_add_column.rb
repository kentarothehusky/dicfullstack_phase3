class AddColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :blogs, :image, :string
    add_column :users, :image, :string
  end
end
