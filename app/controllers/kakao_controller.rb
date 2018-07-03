class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
        :type => "buttons",
        :buttons => ["메뉴", "로또", "고양이"]
    }
    
    render json: @keyboard
    
  end
  
  def message
    @user_msg = params[:content]
    @text = "기본응답"
    if @user_msg == "메뉴"
      @text = ["20층","멀캠식당","급식"].sample
    elsif @user_msg == "로또"
      @text = (1..45).to_a.sample(6).sort.to_s
    elsif @user_msg == "고양이"
      @url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
      @cat_xml = RestClient.get(@url)
      
      # http://www.nokogiri.org/tutorials/parsing_an_html_xml_document.html
      @cat_doc = Nokogiri::XML(@cat_xml)
      
      # http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html
      @cat_url = @cat_doc.xpath("//url").text
      @photo = @cat_url
      
    end
    
    
    @return_msg ={
      :text => @text
    }
    @return_msg_photo = {
      # 사진이 있을 때 사진이 함께 들어간 hash
      :photo => {
        :url => @cat_url,
        :width => 720,
        :height => 630
      }
    }
    
     @return_keyboard = {
        :type => "buttons",
        :buttons => ["메뉴", "로또", "고양이"]
    }
    
    if @user_msg == "고양이"
       @result = {
      :message => @return_msg_photo,
      :keyboard => @return_keyboard
    }
    else
      @result = {
      :message => @return_msg,
      :keyboard => @return_keyboard
    }
    end
    
    render json: @result
  end
end
