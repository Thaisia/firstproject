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
  @photos = Photo.all
  @themes = Theme.all
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

  @photos = Photo.all
  @themes = Theme.all

  if params["ajax"] == "1"
    erb :test, :layout => false
  else
    erb :test
  end
end

get '/tags' do
    if params["ajax"] == "1"
      erb :gallery, :layout => false
    else
      erb :gallery
    end
end

get '/themes' do
  @photos = Photo.all
  @themes = Theme.all
    if params["ajax"] == "1"
      erb :gallery, :layout => false
    else
      erb :gallery
    end
end


get '/manage' do
  erb :manage
end


post '/manage' do

  @theme_name = params[:theme_name]
  @theme_link = params[:theme_link]
  @parent_id = params[:theme_id]
  @tag_name = params[:tag_name]

  t = Theme.new
  t.theme_name = @theme_name
  t.theme_link = @theme_link
  t.parent_id = @parent_id
  t.save

  tg = Tag.new
  tg.tag_name = @tag_name
  tg.save


  for f in params['file'] do
    @filename = f[:filename]
    file = f[:tempfile]

    File.open("./public/test/#{@filename}", 'wb') do |ff|
      ff.write(file.read)

    p = Photo.new
    p.photo_link = @filename
    p.save

    end

  end

  if params["ajax"] == "1"
    erb :manage, :layout => false
  else
    erb :manage
  end
end
