class UsersController < ApplicationController
 def home_page
  redirect_to("/users/")
 end
  def index
    @list_of_users = User.all.order({ :username => :asc})
    render({ :template => "user_templates/index.html.erb"})
  end

  def create
    input_username = params.fetch("input_username")
    a_new_user = User.new
    a_new_user.username = input_username
    a_new_user.save
      redirect_to("/users/" + a_new_user.username)
    end

  def show
    url_username = params.fetch("path_username")
    matching_usernames = User.where({ :username => url_username})
    @the_user = matching_usernames.first

    if @the_user == nil
      redirect_to("/404")
    else
      render({:template => "user_templates/show.html.erb"})
    end 
  end
  def update
    @the_user = User.where({:id => params.fetch("modify_id")}).at(0)
    @the_user.username = params.fetch("input_username")
    @the_user.save
    next_url = "/users/" + @the_user.username
    redirect_to(next_url)
  end
end
