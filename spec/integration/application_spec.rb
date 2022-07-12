require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it 'should return the list of albums' do
      response = get('/albums')

      expected_response = 'Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context 'POST /albums' do
    it 'should add a new album to the db and return it as a last item during the tests' do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')

      repo = AlbumRepository.new
      albums = repo.all
      last_album = albums.last
      expect(response.status).to eq 200
      expect(response.body).to eq ''
      # expect(last_album.title).to eq 'Voyage'
      # expect(last_album.release_year).to eq '2022'
      # expect(last_album.artist_id).to eq '2'

      response = get('/albums')
      expect(response.body).to include('Voyage')
    end
  end

  context 'GET /artists' do
    it 'returns a list of artist names' do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to eq 'Pixies,ABBA,Taylor Swift,Nina Simone,Kiasmos'
    end
  end

  context 'POST /artists' do
    it 'adds a new artist to the db, when get is called, returns the list with the new artist' do
      response = post('artists', name: 'Wild nothing', genre:'Indie')

      expect(response.status).to eq 200
      expect(response.body).to eq 'The artist was added!'

      response = get('artists')
      expect(response.body).to eq 'Pixies,ABBA,Taylor Swift,Nina Simone,Kiasmos,Wild nothing'

    end
  end

end
