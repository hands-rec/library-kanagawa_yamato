require "library/kanagawa_yamato/version"

require "capybara"
require "capybara/dsl"
require "capybara/poltergeist"
require "nokogiri"
require "selenium-webdriver"
require "net/http"
require "pp"

#Capybara.current_driver = :poltergeist
#Capybara.javascript_driver = :poltergeist
#Capybara.app_host = ''
#
#Capybara.register_driver :poltergeist do |app|
#  Capybara::Poltergeist::Driver.new(
#    app,
#    :js_errors => true,
#    :timeout => 60,
#  )
#end
Capybara.current_driver = :selenium

module Library
  module KanagawaYamato
    class Client
      include Capybara::DSL

      def initialize(cardnumber, password)
        Capybara.app_host = 'https://library.city.yamato.kanagawa.jp/'
        @cardnumber = cardnumber
        @password = password
        @borrow_list = nil
      end

      def borrowing
        login
        visit('/licsxp-opac/WOpacMnuTopToPwdLibraryAction.do?gamen=usrlend')
        raise 'error' unless page.title == '貸出状況一覧：蔵書検索システム'

        scrape_borrowing(page.html)
      end

      def scrape_borrowing(source)
        @borrow_list = []
        items = Nokogiri::HTML(source).css('.main table tbody tr')
        items.each do |item|
          i = item.css('td')
          @borrow_list << Book.new(
            title: i[0].text.strip_all,
            date_of_issue: i[3].text.strip_all,
            date_of_return: i[4].text.strip_all,
          )
        end
        @borrow_list
      end

      def login
        visit('/licsxp-opac/WOpacMnuTopInitAction.do?WebLinkFlag=1&moveToGamenId=mylibrary')
        return unless find_by_id('cardnumber')

        sleep_rand
        fill_in('cardnumber', :with => @cardnumber)
        sleep_rand
        fill_in('password', :with => @password)
        sleep_rand
        click_on('ログイン')
      end

      def sleep_rand
        sleep rand(1..5)
      end
    end
  end

  class Book
    attr_accessor :title, :date_of_issue, :date_of_return
    def initialize(title:, date_of_issue:, date_of_return:)
      @title = title
      @date_of_issue = Date.parse(date_of_issue)
      @date_of_return = Date.parse(date_of_return)
    end
  end
  
end

class String
  def strip_all!
    self.strip.gsub!(/^[　\s]*(.*?)[　\s]*$/, '\1')
  end
  def strip_all
    clone.strip_all!
  end
end
