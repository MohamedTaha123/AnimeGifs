class RemoveImagesHashFromImages < ActiveRecord::Migration[6.0]
  def change
    remove_column :images, :images_hash, :string
  end
end
