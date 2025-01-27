class PhotosController < ApplicationController
  def index
    @list_of_photos = Photo.all.order({ :created_at => "desc" })
    render({ :template => "photos_templates/index.html.erb"})
  end

  def show
    @the_photo = Photo.where({ :id => params.fetch("path_id")}).first
    render({ :template => "photos_templates/show.html.erb"})
  end

  def delete
    matching_photos = Photo.where({ :id => params.fetch("destroy_id")})
    the_photo = matching_photos.at(0)
    the_photo.destroy
    redirect_to("/photos")
  end
  
  def create
  input_image = params.fetch("input_image")
  input_caption = params.fetch("input_caption")
  input_owner_id = params.fetch("input_owner_id")
  a_new_photo = Photo.new
  a_new_photo.image = input_image
  a_new_photo.caption = input_caption
  a_new_photo.owner_id = input_owner_id
  a_new_photo.save
    redirect_to("/photos/" + a_new_photo.id.to_s)
  end

  def update
    @the_photo = Photo.where({:id => params.fetch("modify_id")}).at(0)
    input_image = params.fetch("input_image")
    input_caption = params.fetch("input_caption")
    @the_photo.image = input_image
    @the_photo.caption = input_caption
    @the_photo.save
    next_url = "/photos/" + @the_photo.id.to_s
    redirect_to(next_url)
  end

  def add_comment
    @the_photo = Photo.where({:id => params.fetch("input_photo_id")}).at(0)
    input_author = params.fetch("input_author_id")
    input_comment = params.fetch("input_body")
    a_new_comment = Comment.new
    a_new_comment.author_id = input_author
    a_new_comment.body = input_comment
    a_new_comment.photo_id = params.fetch("input_photo_id")
    a_new_comment.save
      redirect_to("/photos/" + @the_photo.id.to_s)
    end
end