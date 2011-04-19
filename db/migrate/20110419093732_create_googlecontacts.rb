class CreateGooglecontacts < ActiveRecord::Migration
  def self.up
    create_table :googlecontacts do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :googlecontacts
  end
end
