class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t| #create a new table
			t.string :name #with a column called "name" of type "string"
			t.string :password #and a column called "password" of type "string" 
    	t.timestamps #And the built-in rails timestamps
    end
  end
end
