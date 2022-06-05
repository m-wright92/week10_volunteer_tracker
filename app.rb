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

#the .split .map added to title capitalizes the first letter in each word of the title
post '/projects' do
  title = params[:project_title]
  if title.count('a-z') > 0
    project = Project.new({:title => title.split(/ |\_/).map(&:capitalize).join(" "), :id => nil})
    project.save
  end
  redirect to '/projects'
end

get '/projects/:id' do
  @project = Project.find(params[:id].to_i)
  @volunteers = Volunteer.all
  if @project
    erb :project
  elsif nil
    erb :no_project
  end
end

get '/projects/:id/edit' do
  @project = Project.find(params[:id].to_i)
  erb :edit_project
end

patch '/projects/:id' do
  @project = Project.find(params[:id].to_i)
  @project.update({:title => params[:title].split(/ |\_/).map(&:capitalize).join(" ")})
  @projects = Project.all
  erb :projects
end

delete '/projects/:id' do
  project = Project.find(params[:id].to_i)
  project.delete
  @projects = Project.all
  erb :projects
end

get '/volunteers' do
  @volunteers = Volunteer.all
  erb :volunteers
end

get '/volunteers/new' do
  erb :new_volunteer
end

post '/volunteers/new' do
  name = params[:volunteer_name]
  if name.count('a-z') > 0
    volunteer = Volunteer.new({:name => name.capitalize, :project_id => 0, :id => nil})
    volunteer.save
  end
  @volunteers = Volunteer.all
  erb :volunteers
end

get '/volunteers/:id' do
  @volunteer = Volunteer.find(params[:id].to_i)
  if @volunteer.project_id != 0
    @project = Project.find(@volunteer.project_id)
  else 
    @project = nil
  end
  erb :volunteer
end

get '/volunteers/:id/edit' do
  @volunteer = Volunteer.find(params[:id].to_i)
  @projects = Project.all
  erb :edit_volunteer
end

delete '/volunteers/:id' do
  @volunteer = Volunteer.find(params[:id].to_i)
  @volunteer.delete
  redirect to '/volunteers' 
end

patch '/volunteers/:id/edit' do
  @volunteer = Volunteer.find(params[:id].to_i)
  @volunteer.update({:project_id => params[:proj_title]})
  @projects = Project.all
  redirect to "/volunteers/#{@volunteer.id}"
end