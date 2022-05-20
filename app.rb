require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require 'pg'
require './lib/project'
require './lib/volunteer'
also_reload 'lib/**/*.rb'

DB = PG.connect({:dbname => 'volunteer_tracker'})

get '/' do
  @projects = Project.all
  erb :projects
end

get '/projects' do
  @projects = Project.all
  erb :projects
end

get '/projects/new' do
  erb :new_project
end