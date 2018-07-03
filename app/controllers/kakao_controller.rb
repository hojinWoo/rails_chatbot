class KakaoController < ApplicationController
  def keyboard
    @keyboard = {
        :type => "buttons",
        :buttons => ["메뉴", "로또", "고양이"]
    }
    
    render json: @keyboard
    
  end
  
  def message
  end
end
