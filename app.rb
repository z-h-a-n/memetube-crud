require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'pry-byebug'


get '/' do
	redirect to ('/videos')
end

get '/videos' do
	sql = "SELECT * FROM videos"
	@videos = run_sql(sql)
	erb :index
end

get '/videos/new' do
	erb :new
end

post '/videos' do
	sql = "INSERT INTO videos (title, description, url, genre) values ('#{params[:title]}', '#{params[:description]}', '#{params[:url]}', '#{params[:genre]}')"
	run_sql(sql)
	redirect to('/videos')
end

get '/videos/:id' do
	sql = "SELECT * FROM videos where id = #{params[:id]}"
	@video = run_sql(sql).first
	erb :show
end

get '/videos/:id/edit' do
	sql = "SELECT * FROM videos where id = #{params[:id]}"
	@video = run_sql(sql).first
	erb :edit
end

post '/videos/:id' do
	sql = "UPDATE videos set title = '#{params[:title]}', description = '#{params[:description]}', url = '#{params[:url]}', genre = '#{params[:genre]}' where id = '#{params[:id]}'"
	run_sql(sql)
	redirect to("/videos/#{params[:id]}")
end

delete '/videos/:id/delete' do
	sql = "delete from videos where id = #{params[:id]}"
	run_sql(sql)
	redirect to('/videos')
end


private
def run_sql(sql)
	conn = PG.connect(dbname: 'memetube_app', host: 'localhost')
	begin
		result = conn.exec(sql)
	ensure
		conn.close
	end
	result
end


