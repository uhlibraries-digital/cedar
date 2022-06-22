class AddSpoiledToVocabularyExports < ActiveRecord::Migration
  def change
    add_column :vocabulary_exports, :spoiled, :boolean, default: false
  end
end
