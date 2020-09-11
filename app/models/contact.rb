class Contact < ApplicationRecord
  belongs_to :user
  #equivalent of define (no preprocess)
  include Filterable
  
# Validate
    # First name must exist
    validates :first_name, presence: true

    # Mobile number needs 10 digits
    validates :primary_phone, format: { with: /\d{10}/}
    validates :primary_phone, length: { is: 10 }

    # Email needs to contain '@' and '.' with at least 1 character before and after
    validates :email, format: { with: /.+\@.+\..+/}

#Search and Sort    
    # Pull only contacts owned by current user
    def self.users_contacts(user_id)
        where user_id: user_id
    end 

    # TODO -- implement sorting
    def self.alphabetical
        self.all.order(:last_name)
    end
end
