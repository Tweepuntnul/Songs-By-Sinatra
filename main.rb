require 'sinatra'
require 'sinatra/reloader' if development?  #doesn't work with sessions 
require './song'
require 'slim'
require 'sass'

get('/styles.css') { scss :styles }

configure do
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

configure do
	enable :sessions
end

get '/login' do
	slim :login
end

post '/login' do
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		slim :login
	end
end

get '/logout' do
	session.clear
	redirect to('/login')
end

get '/set/:name' do
	session[:name] = params[:name]
end

get '/get/hello' do
	"Hello #{session[:name]}"
end

# layout

get '/' do
	slim :home 
end

get '/about' do 
	@title = "All About This Website" 
	slim :about
end

get '/contact' do
	@title = "You can contact me!"
	slim :contact
end

not_found do
	@title = "HAHAHA"
	slim :is404
end