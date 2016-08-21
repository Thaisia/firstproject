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
  @main = db.execute 'select * from main;'
	@faces = db.execute 'select * from faces;'
end

get '/' do
	erb :main
end

get '/faces' do
	erb :faces, :layout => false
end

get '/places' do
	erb :places
end

get '/events' do
	erb :events
end

get '/closeup' do
	erb :closeup
end

get '/coaching' do
	erb :coaching
end

get '/aboutme' do
	erb :aboutme
end
