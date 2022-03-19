class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.json :params, null: false, default: {}
      t.json :headers
      t.string :http_method
      t.references :endpoint
      t.datetime :created_at, null: false
    end
  end
end
