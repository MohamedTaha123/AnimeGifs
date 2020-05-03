class AddImpressionsCountToGif < ActiveRecord::Migration[6.0]
  def change
    add_column :gifs, :impressions_count, :int
  end
end
