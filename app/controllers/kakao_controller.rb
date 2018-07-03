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
    end
    
    
    @return_msg ={
      :text => @text
    }
    @return_keyboard = {
        :type => "buttons",
        :buttons => ["메뉴", "로또", "고양이"]
    }
    
    @result = {
      :message => @return_msg,
      :keyboard => @return_keyboard
    }
    render json: @result
  end
end
