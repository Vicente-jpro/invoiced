class Contact < ApplicationRecord
 validates :first_name, presence: true 
 validates :last_name, presence: true 
 validates :email, presence: true

 scope :order_by_created_at_desc, -> { order(created_at: :desc) }
 scope :search_all_by_first_name, ->(key) {where('LOWER(first_name) LIKE ?', "%#{key.downcase}%") if key.present?}
end
