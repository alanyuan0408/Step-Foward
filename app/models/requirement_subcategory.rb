class RequirementSubcategory < ActiveRecord::Base

	belongs_to :requirement_category

	has_many :project_requirements
	has_many :student_attributes

	validates :sub_category_name, presence: true, allow_blank: false, uniqueness: true
	
	attr_accessible :sub_category_name, :attribute_type, :placeholder, :student_attribute, :upper_limit, :lower_limit, :regex
	
end
