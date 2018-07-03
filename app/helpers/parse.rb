require 'nokogiri'
require 'rest-client'
# helper 수정시 서버 껏다가 켜야 함.

# module : class의 상위 개념,, nokogiri도 module로서 사용 된 것.
module Parse
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