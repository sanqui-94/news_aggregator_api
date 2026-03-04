class CreateFoundationTables < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :provider, null: false
      t.string :uid,      null: false
      t.string :email,    null: false
      t.string :name,     null: false
      t.string :avatar_url
      t.string :role,     null: false, default: "user"

      t.timestamps
    end

    add_index :users, %i[provider uid], unique: true
    add_index :users, :email,           unique: true

    create_table :sources do |t|
      t.string   :name,            null: false
      t.string   :url,             null: false
      t.string   :site_url
      t.text     :description
      t.boolean  :active,          null: false, default: true
      t.datetime :last_fetched_at

      t.timestamps
    end

    add_index :sources, :url, unique: true

    create_table :articles do |t|
      t.references :source,       null: false,
                                  foreign_key: { on_delete: :cascade }
      t.string     :title,        null: false
      t.string     :url,          null: false
      t.text       :summary
      t.datetime   :published_at, null: false
      t.string     :external_id,  null: false

      t.timestamps
    end

    add_index :articles, %i[source_id external_id], unique: true
    add_index :articles, %i[source_id published_at]

    create_table :tags do |t|
      t.string :name, null: false
      t.string :slug, null: false

      t.timestamps
    end

    add_index :tags, :name, unique: true
    add_index :tags, :slug, unique: true
  end
end