require 'nokogiri'
require 'rest-client'
require 'open-uri'
# helper 수정시 서버 껏다가 켜야 함.

# module : class의 상위 개념,, nokogiri도 module로서 사용 된 것.
module Parse
    class Hospital
        def self.name
           url = "http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList?emdongNm=%EC%8B%A0%EA%B0%88%EB%8F%99&radius=3000&ServiceKey=QaF1DC23RvHRq4cW5OWsAc4OdF2aocCEzPIVRqamSp5em%2F%2FmLWBcH28Yzp2685EqMzQE%2Fag155d5CBsXxim9Wg%3D%3D"
           name_xml = RestClient.get(url)
           name_doc = Nokogiri::XML(name_xml)
           
           name_title = Array.new
           # 이름 가져오기
           name_doc.xpath("//yadmNm").each do |nn|
               name_title << nn.text
           end
           puts name_title
           return name_title.to_s
        end
    end
    class Movie
        def naver
            # 네이버 현재상영영화중 하나를 랜덤으로 뽑아주는 코드
            doc = Nokogiri::HTML(open("https://movie.naver.com/movie/running/current.nhn"))
            movie_title = Array.new
            
            doc.css("ul.lst_detail_t1 dt a").each do |title|
            	movie_title << title.text
            end
            # all
            # title = movie_title.to_s
            title = movie_title.sample
            return "<" + title + ">"
        end
    end
    class Animal
        def self.cat
            url = "http://thecatapi.com/api/images/get?format=xml&type=jpg"
            cat_xml = RestClient.get(url)
            # http://www.nokogiri.org/tutorials/parsing_an_html_xml_document.html
            cat_doc = Nokogiri::XML(cat_xml)
            # http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html
            cat_url = cat_doc.xpath("//url").text
            # 자동적으로 마지막 연산을 return 해준다.
            #return cat_url
        end
    end
end