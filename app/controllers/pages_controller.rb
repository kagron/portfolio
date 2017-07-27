class PagesController < ApplicationController
    
    def index
        @post = Post.last
    end
end
