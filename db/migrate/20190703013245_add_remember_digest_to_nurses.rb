class AddRememberDigestToNurses < ActiveRecord::Migration[5.2]
  def change
    add_column :nurses, :remember_digest, :string
  end
end
