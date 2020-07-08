class Author < ApplicationRecord
	validates :first_name, :last_name , :date_of_birth ,presence: true
	has_and_belongs_to_many :books 
end
