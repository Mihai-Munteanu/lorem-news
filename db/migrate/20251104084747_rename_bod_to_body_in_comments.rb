class RenameBodToBodyInComments < ActiveRecord::Migration[8.1]
  def change
    rename_column :comments, :body, :body
  end
end
