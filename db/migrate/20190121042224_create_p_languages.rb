class CreatePLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :p_languages do |t|
      t.string :name
      t.string :wiki_link

      t.timestamps
    end
  end
end
