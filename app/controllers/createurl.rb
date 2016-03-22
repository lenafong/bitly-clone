get '/' do
	if Url.all != []
		@url = Url.all.order('id DESC').first
		@trackingrecord = Url.all.where("id != ?", @url.id).order('id DESC')
		erb :"static/index"
	else
		erb :"static/index2"
	end
end

post '/urls' do 
	#to check if the url exists, to avoid duplication
	checking = Url.find_by(long_url: params[:long_url])

	if checking != nil
		checking.update(id: Url.last.id+1)
		redirect '/'
	else
		@url=Url.new(id: Url.last.id+1, long_url: params[:long_url])
		if @url.save
			redirect '/'
		else 
			@error = @url.errors.messages[:long_url]
			if Url.all != []
				@url = Url.all.order('id DESC').first
				@trackingrecord = Url.all.where("id != ?", @url.id).order('id DESC')
				erb :"static/index"
			else
				erb :"static/index2"
			end
		end
	end

end 

get '/:short_url' do
	url = Url.find_by(shortened_url: params[:short_url])
	url.update(click_count: url.click_count+1)
	redirect url.long_url
end 