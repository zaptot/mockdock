class CreateEndpoints < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE request_method AS ENUM ('post', 'get', 'put', 'delete', 'patch', 'options');
    SQL

    create_table :endpoints, id: :bigserial do |t|
      t.string :path, null: false
      t.jsonb :response_data, null: false, default: {}
      t.integer :response_code, null: false, default: 200
      t.column :http_method, :request_method, null: false

      t.index %i[path http_method], unique: true
    end
  end

  def down
    drop_table :endpoints
    execute 'DROP TYPE request_method;'
  end
end
