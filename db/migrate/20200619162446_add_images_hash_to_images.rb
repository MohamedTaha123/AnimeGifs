class AddImagesHashToImages < ActiveRecord::Migration[6.0]
  def change
    add_column :images, :images_hash, :json
  end
end
