#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sqlite3"

def get_db
  db = SQLite3::Database.new "test.db"
  db.results_as_hash = true
  return db
end

before do
  db = get_db
  @themes = db.execute 'select * from themes;'
  @tags = db.execute 'select * from tags'
  @pho_tags = db.execute 'select pic_link from pho join pho_tags on pho.id = pho_tags.photos_id where tags_id  = 19'
end

get '/' do
  db = get_db
  @main = db.execute 'select * from pho;'
	erb :main
end

get '/aboutme' do
  db = get_db
    @photos = db.execute 'select pic_link from pho;'
@counter = 1
  if params["ajax"] == "1"
    erb :aboutme, :layout => false
  else
    erb :aboutme
  end
end




get '/test' do
  db = get_db
  @tmp = db.execute "SELECT COUNT(*) FROM pho;"
  @tmp2 = @tmp[0]
  @count = @tmp2[0]

  @num = 20
  if params["ajax"] == "1"
    erb :test, :layout => false
  else
    erb :test
  end
end


get '/test/:pagenum' do
  db = get_db
  @page1 = db.execute 'select pic_link from pho limit ?,12;', params[:pagenum]

  if params["ajax"] == "1"
    erb :test2, :layout => false
  else
    erb :test2
  end
end


get '/tags/:url_part' do
    db = get_db
    @tags_id = db.execute 'select id from tags where tag_name=?', params[:url_part]
    tag_id = @tags_id[0]['id']
    @photos = db.execute 'select pic_link from pho join pho_tags on pho.id = pho_tags.photos_id where tags_id  = ?', tag_id
    if params["ajax"] == "1"
      erb :gallery, :layout => false
    else
      erb :gallery
    end
end








get '/themes/:url_part' do
    db = get_db

    @theme_id = db.execute 'select id from themes where theme_link=?', params[:url_part]
    theme_id = @theme_id[0]['id']

    @photos = db.execute 'select pic_link from pho join themes on pho.theme_id = themes.id where theme_id = ? or themes.parent_id = ? or themes.parent_id in (select id from themes where parent_id=?);',
     theme_id, theme_id, theme_id

    if params["ajax"] == "1"
      erb :gallery, :layout => false
    else
      erb :gallery
    end
end
