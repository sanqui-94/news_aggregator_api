class CreateWorkflowTables < ActiveRecord::Migration[8.1]
  def change
    create_table :feeds do |t|
      t.references :user, null: false,
                          foreign_key: { on_delete: :cascade }
      t.string :name,     null: false

      t.timestamps
    end

    create_table :feed_sources do |t|
      t.references :feed,   null: false,
                            foreign_key: { on_delete: :cascade }
      t.references :source, null: false,
                            foreign_key: { on_delete: :cascade }

      t.timestamps
    end

    add_index :feed_sources, %i[feed_id source_id], unique: true

    create_table :source_suggestions do |t|
      t.references :user,        foreign_key: { on_delete: :nullify },
                                 null: true
      t.references :reviewed_by, foreign_key: { to_table: :users,
                                                on_delete: :nullify },
                                 null: true
      t.string     :url,         null: false
      t.text       :description, null: false
      t.string     :status,      null: false, default: "pending"
      t.text       :admin_notes
      t.datetime   :reviewed_at

      t.timestamps
    end

    add_index :source_suggestions, :status

    create_table :notifications do |t|
      t.references :user, null: false,
                          foreign_key: { on_delete: :cascade }
      t.string  :type,    null: false
      t.boolean :read,    null: false, default: false
      t.jsonb   :data,    null: false, default: {}

      t.datetime :created_at, null: false
    end

    add_index :notifications, %i[user_id read]
  end
end