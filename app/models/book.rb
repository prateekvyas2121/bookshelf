class Book < ApplicationRecord
	# attr_accessor :author_ids
	validates :title,presence: true
	# validates :author_id, presence: true
	has_and_belongs_to_many :authors

	# validate :authors_count
 
 # 	private
	# def authors_count
	# 	if self.authors.count == 0
	# 	  errors.add(:books, "must exist")
	# 	end
	# 	# p "============================================================================================================================================="
	# 	# puts self.authors.count
	# end
end
