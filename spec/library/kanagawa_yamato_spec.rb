require 'spec_helper'
require 'pp'

describe Library::KanagawaYamato do
  it 'has a version number' do
    expect(Library::KanagawaYamato::VERSION).not_to be nil
  end
end

describe Library::KanagawaYamato::Client do
  
#  describe '#borrowing' do
#    it 'success' do
#      c = Library::KanagawaYamato::Client.new('', '')
#      c.borrowing
#    end
#  end

  describe '#scrape_borrowing' do
    before :each do
      @client = Library::KanagawaYamato::Client.new('dummy', 'dummy')
      @source_count_20_under = open('./spec/data/scraping/kanagawa-yamato-borrw.html')
    end

    it 'count is 16' do
      borrowing_list = @client.scrape_borrowing(@source_count_20_under)
      expect(borrowing_list.size).to eq 7 
    end

    describe 'count 20 under' do
      before :each do
        @borrowing_list = @client.scrape_borrowing(@source_count_20_under)
      end

      describe 'first book' do
        it 'title' do
          expect(@borrowing_list[0].title).to eq 'うさこちゃんのにゅういん　ディック・ブルーナ／ぶん え　福音館書店'
        end
        it 'issue date' do
          expect(@borrowing_list[0].date_of_issue.to_s).to eq '2016-10-02'
        end
        it 'return date' do
          expect(@borrowing_list[0].date_of_return.to_s).to eq '2016-10-16'
        end
      end

      describe 'fourth book' do
        it 'title' do
          expect(@borrowing_list[4].title).to eq 'もとこども　ポプラ社の絵本 37　富安 陽子／作　ポプラ社'
        end
        it 'issue date' do
          expect(@borrowing_list[4].date_of_issue.to_s).to eq '2016-09-25'
        end
        it 'return date' do
          expect(@borrowing_list[4].date_of_return.to_s).to eq '2016-10-23'
        end
      end
    end
  end
end
