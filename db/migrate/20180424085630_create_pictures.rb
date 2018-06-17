class CreatePictures < ActiveRecord::Migration[5.1]
  def change
    create_table :pictures do |t|
      t.text :image
      t.string :description

      t.timestamps
    end
  end
end
