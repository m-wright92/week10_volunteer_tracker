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

#the .split .map added to title capitalizes the first letter in each word of the title
post '/projects' do
  title = params[:project_title]
  project = Project.new({:title => title.split(/ |\_/).map(&:capitalize).join(" "), :id => nil})
  project.save
  redirect to '/projects'
end

get '/projects/:id' do
  @project = Project.find(params[:id].to_i)
  @volunteers = Volunteer.all
  if @project
    erb :project
  else
    erb :no_project
  end
end