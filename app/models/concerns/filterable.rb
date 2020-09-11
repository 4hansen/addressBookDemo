# Class equivalent of scope :filter_by_var, -> (where (var like ?, #{var}%))

module Filterable
    extend ActiveSupport::Concern

    module ClassMethods
        def filter_by_params (filtering_params)
            where("first_name LIKE ?", filtering_params ).or(where("last_name like ?", filtering_params ))
            
        end #filterable
    end #ClassMethods
    
end #module