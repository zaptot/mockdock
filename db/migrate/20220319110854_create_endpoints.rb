class CreateEndpoints < ActiveRecord::Migration[6.1]
  def change
    create_table :endpoints do |t|
      t.string :path, null: false
      t.json :response_data, null: false, default: {}
      t.integer :response_code, null: false, default: 200
      t.string :http_method, null: false

      t.index %i[path http_method], unique: true
    end
  end
end
