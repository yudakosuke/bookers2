class ChangeBodyLengthOfBooks < ActiveRecord::Migration[6.1]
  def change
   change_column :books, :body, :string, limit: 200
  end
end
