class AddVisibilityToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :visibility, :string
  end
end
