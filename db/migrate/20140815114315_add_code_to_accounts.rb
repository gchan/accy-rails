class AddCodeToAccounts < ActiveRecord::Migration
  def change
    add_column :plutus_accounts, :code, :string

    add_index :plutus_accounts, :code
    add_index :plutus_accounts, :name
  end
end
