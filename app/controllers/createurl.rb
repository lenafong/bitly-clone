get '/' do
	@urls = Url.all.order('id DESC')
	@url = nil
	erb :"static/index"
end

post '/urls' do 
	@url=Url.new(long_url: params[:long_url])
	if @url.save
		redirect '/'
	else 
		@error = @url.errors.messages[:long_url]
		@urls = Url.all.order('id DESC')
		erb :"static/index"
	end
end 

get '/:short_url' do
	url = Url.find_by(shortened_url: params[:short_url])
	url.update(click_count: url.click_count+1)
	redirect url.long_url
end 