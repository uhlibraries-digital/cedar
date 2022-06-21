class CreateVocabularyExports < ActiveRecord::Migration
  def change
    create_table :vocabulary_exports do |t|
      t.string :token
      t.text :log
      t.boolean :success, default: false
      t.timestamp :finished_at
      t.timestamps null: false
    end
  end
end
