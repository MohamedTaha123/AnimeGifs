class AddTagTagListToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :tag_list, :string
  end
end
