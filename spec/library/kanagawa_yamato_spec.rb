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
#      c = Library::KanagawaYamato::Client.new
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
      expect(borrowing_list.size).to eq 16
    end

    it 'count 20 under' do
      borrowing_list = @client.scrape_borrowing(@source_count_20_under)

      expect(borrowing_list[0].title).to eq 'エジソン　オールカラーまんがで読む知っておくべき世界の偉人 18　イ スジョン／文　岩崎書店'
      expect(borrowing_list[0].date_of_issue).to eq '2016/07/09'
      expect(borrowing_list[0].date_of_return).to eq '2016/08/06'

      expect(borrowing_list[4].title).to eq 'へんしんクイズ　新しいえほん　あきやま ただし／作・絵　金の星社'
      expect(borrowing_list[4].date_of_issue).to eq '2016/07/31'
      expect(borrowing_list[4].date_of_return).to eq '2016/08/14'
    end
  end

end
