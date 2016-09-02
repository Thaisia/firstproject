#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sinatra/activerecord"

set :database, "sqlite3:myphotosite.db"

class Photo < ActiveRecord::Base
end

class Theme < ActiveRecord::Base
end

class Tag < ActiveRecord::Base
end

class Bind < ActiveRecord::Base
end

before do
  @photos = Photo.all
  @themes = Theme.all
  @tags = Tag.all
  @binds = Bind.all
end
get '/' do
  erb :main
end

get '/aboutme' do
  if params["ajax"] == "1"
    erb :aboutme, :layout => false
  else
    erb :aboutme
  end
end


get '/test' do
  if params["ajax"] == "1"
    erb :test, :layout => false
  else
    erb :test
  end
end

get '/tag/:tag_name' do

tag = Tag.find_by tag_name: params[:tag_name]
@photos_load = Photo.joins("inner join binds on binds.photo_id = photos.id").where("tag_id = ?", tag.id )

    if params["ajax"] == "1"
      erb :gallery, :layout => false
    else
      erb :gallery
    end
end


get '/themes/:theme_link' do

  theme = Theme.find_by theme_link: params[:theme_link]
  puts theme.id


#select pic_link from pho join themes on pho.theme_id = themes.id where theme_id = ? or themes.parent_id = ? or themes.parent_id in (select id from themes where parent_id=?);', theme_id, theme_id, theme_id
#@photos_load = Photo.joins("inner join themes on binds.photo_id = photos.id").where("tag_id = ?", tag.id )


test1 = Theme.where("id = ?", theme.id)
puts test1
  puts "*-***************************************************************************"
    if params["ajax"] == "1"
      erb :gallery, :layout => false
    else
      erb :gallery
    end
end


get '/manage' do
  if params["ajax"] == "1"
    erb :manage, :layout => false
  else
    erb :manage
  end
end

post '/edit_photo' do
  @theme_id = params[:theme_id]
  @photo_id = params[:photo_id]
  @tag_id = params[:tag_id]

  photo = Photo.find(@photo_id)
  photo.theme_id = @theme_id
  photo.save

  redirect '/manage'
end

post '/edit_tags' do
  @photo_id = params[:photo_id]
  @tag_id = params[:tag_id]
  puts @tag_id

  for tid in @tag_id do
    b = Bind.new
    b.photo_id = @photo_id
    b.tag_id = tid[0].to_i
    b.save
  end

    erb "ok"
end

post '/manage' do

  @theme_name = params[:theme_name]
  @theme_link = params[:theme_link]
  @parent_id = params[:theme_id]
  @tag_name = params[:tag_name]
  @theme_id = params[:theme_id]
  @photo_id = params[:photo_id]

#  t = Theme.new
#  t.theme_name = @theme_name
#  t.theme_link = @theme_link
#  t.parent_id = @parent_id
#  t.save

#  tg = Tag.new
#  tg.tag_name = @tag_name
#  tg.save

  for f in params['file'] do
    @filename = f[:filename]
    file = f[:tempfile]

    File.open("./public/content/#{@filename}", 'wb') do |ff|
      ff.write(file.read)

    p = Photo.new
    p.photo_link = @filename
    p.save

    end

  end

  @photo_tmp_id = 0

  if params["ajax"] == "1"
    erb :manage, :layout => false
  else
    erb :manage
  end
end
