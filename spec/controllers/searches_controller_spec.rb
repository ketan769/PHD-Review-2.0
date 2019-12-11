require 'rails_helper'
require 'spec_helper'

describe SearchesController do
  describe 'search user with uin' do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:similar_movies).with('Harry Potter')
      get :movie_with_same_director, { title: 'Harry Potter' }
    end

    it 'Need to assign similar movies if director exists' do
      movies = ['Absurdity1', 'Absurdity2']
      Movie.stub(:similar_movies).with('Absurdity1').and_return(movies)
      get :movie_with_same_director, { title: 'Absurdity1' }
      expect(assigns(:similar_movies)).to eql(movies)
    end

    it "should redirect to home page if director isn't known" do
      Movie.stub(:similar_movies).with('Stupidity').and_return(nil)
      get :movie_with_same_director, { title: 'Stupidity' }
      expect(response).to redirect_to(movies_path)
    end
  end
end