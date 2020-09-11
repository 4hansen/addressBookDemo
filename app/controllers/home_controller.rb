class HomeController < ApplicationController

    def index
        if(current_user)
           redirect_to contacts_path 
        end
    end
end
