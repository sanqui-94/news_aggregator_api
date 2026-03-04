class CreateJoinTables < ActiveRecord::Migration[8.1]
  def change
    create_table :source_tags do |t|
      t.references :source, null: false,
                            foreign_key: { on_delete: :cascade }
      t.references :tag,    null: false,
                            foreign_key: { on_delete: :restrict }

      t.timestamps
    end

    add_index :source_tags, %i[source_id tag_id], unique: true

    create_table :default_feed_sources do |t|
      t.references :source, null: false,
                            foreign_key: { on_delete: :cascade },
                            index: { unique: true }

      t.datetime :created_at, null: false
    end
  end
end