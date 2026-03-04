class RemoveRedundantSourceIdIndexFromArticles < ActiveRecord::Migration[8.1]
  def change
    remove_index :articles, name: "index_articles_on_source_id"
  end
end