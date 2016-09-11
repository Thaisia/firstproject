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

LIMIT = 30

before do
  @themes = Theme.all
  @tags = Tag.all
    @photos = Photo.all
end

get '/' do

  @all_photos = Photo.order(:shuffle_num)
  offset = params.fetch("offset", 0).to_i
  @photos = @all_photos.offset(offset).limit(LIMIT)

  all_length = @all_photos.length
  remaining_length = all_length - (offset + @photos.length)
  if remaining_length < LIMIT / 2
    @photos = @all_photos.offset(offset)
    @more = false
  else
    @more = true
  end

  @offset = offset
  @new_offset = offset + @photos.length

  if params["ajax"] == "1"
    erb :gallery, :layout => false
  else
    erb :gallery
  end

end

get '/aboutme' do

  if params["ajax"] == "1"
    erb :aboutme, :layout => false
  else
    erb :aboutme
  end
end

get '/tag/:tag_name' do
  offset = params.fetch("offset", 0).to_i

  @tag = Tag.find_by tag_name: params[:tag_name]
  @all_photos = Photo.joins(
    "inner join binds on binds.photo_id = photos.id"
  ).where(
    "tag_id = ?", @tag.id
  ).order(:shuffle_num)
  @photos = @all_photos.offset(offset).limit(LIMIT)

  all_length = @all_photos.length
  remaining_length = all_length - (offset + @photos.length)
  if remaining_length < LIMIT / 2
    @photos = @all_photos.offset(offset)
    @more = false
  else
    @more = true
  end

  @offset = offset
  @new_offset = offset + @photos.length

  if params["ajax"] == "1"
    erb :gallery, :layout => false
  else
    erb :gallery
  end
end

get '/themes/:theme_link' do
  offset = params.fetch("offset", 0).to_i

  @theme = Theme.find_by theme_link: params[:theme_link]
  subthemes = Theme.select("id").where(parent_id: @theme.id)
  themes = Theme.select('id').where(
    "id = ? or parent_id = ? or parent_id in (?)",
    @theme.id, @theme.id, subthemes
  )

  @all_photos = Photo.where('theme_id in (?)', themes)
  @photos = @all_photos.offset(offset).limit(LIMIT)

  all_length = @all_photos.length
  remaining_length = all_length - (offset + @photos.length)
  if remaining_length < LIMIT / 2
    @photos = @all_photos.offset(offset)
    @more = false
  else
    @more = true
  end

  @offset = offset
  @new_offset = offset + @photos.length

  if params["ajax"] == "1"
    erb :gallery, :layout => false
  else
    erb :gallery
  end
end

get '/manage' do
=begin
  @themes_ddl = Theme.where('container = 1')
  @photos = Photo.all

  if params["ajax"] == "1"
    erb :manage, :layout => false
  else
    erb :manage
  end
=end
  erb "Дратути =)"
end

post '/edit_photo' do
=begin
  @themes_ddl = Theme.where('container = 1')
  @theme_id = params[:theme_id]
  @photo_id = params[:photo_id]
  @tag_id = params[:tag_id]

  photo = Photo.find(@photo_id)
  photo.theme_id = @theme_id
  photo.save

  redirect '/manage'
=end
  erb "Дратути =)"
end

post '/edit_tags' do
=begin
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
=end
    erb "Дратути =)"
end

post '/manage' do
=begin
  @themes_ddl = Theme.where('container = 1')
  @photos = Photo.all
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
    p.theme_id = 33
    p.shuffle_num = rand(111111..999999)
    p.save


    end

  end

  @photo_tmp_id = 0

  if params["ajax"] == "1"
    erb :manage, :layout => false
  else
    erb :manage
  end
=end
  erb "Дратути =)"
end
