class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
        :type => "buttons",
        :buttons => ["메뉴", "로또", "고양이"]
    }
    
    render json: @keyboard
    
  end
  
  #https://github.com/plusfriend/auto_reply#53-%EC%B9%9C%EA%B5%AC-%EC%B6%94%EA%B0%80%EC%B0%A8%EB%8B%A8-%EC%95%8C%EB%A6%BC-api 참고
  def friend_add
    #친구 추가시 친구 찾기
    User.create(user_key: params[:user_key], chat_room: 0)
    render nothing: true #카카오에서 200만 응답 받는다고 하니까 자체적으로 보낼 것은 없음
  end
  
  def friend_delete
    #find methods는 id로 값을 찾지만 find_by는 column으로 찾을 수 있음
    User.find_by(user_key: params[:user_key]).destroy
    render nothing: true
  end
  
  #[채팅방에서 나가기] 할 때마다 chat_room의 count가 올라가게 하기
  def chat_room
    user = User.find_by(user_key: params[:user_key])
    user.plus #User.rb에서 만든 methods
    user.save
    render nothing: true
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
