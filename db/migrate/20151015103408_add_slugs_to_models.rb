class AddSlugsToModels < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true

    add_column :books, :slug, :string
    add_index :books, :slug, unique: true
  end
end
