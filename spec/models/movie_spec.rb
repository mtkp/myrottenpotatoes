require 'spec_helper'

describe Movie do

  subject { @movie = Movie.new(title: "My New Movie", rating: "PG-13",
    release_date: "2004-01-03", ) }

  it { should respond_to :title }
  it { should respond_to :rating }
  it { should respond_to :release_date }
  it { should respond_to :description }
  it { should respond_to :grandfathered? }
  it { should respond_to :released_1930_or_later }

  describe "searching TMDb by keyword" do
    it "should call TMDb with title keywords given valid API key" do
      TmdbMovie.should_receive(:find).with(hash_including title: "Inception")
      Movie.find_in_tmdb("Inception")
    end
    it "should raise an InvalidKeyError with no API key" do
      Movie.stub(:api_key).and_return ""
      lambda { Movie.find_in_tmdb("Inception") }.
        should raise_error(Movie::InvalidKeyError)
    end
    it "should raise an InvalidKeyError with invalid API key" do
      TmdbMovie.stub(:find).
        and_raise(RuntimeError.new("Tmdb API returned status code '404'"))
      lambda { Movie.find_in_tmdb("Inception") }.
        should raise_error(Movie::InvalidKeyError)
    end
    it "should raise a RuntimeError if the message doesn't include code 404" do
      TmdbMovie.stub(:find).
        and_raise(RuntimeError.new("Error That You Can't Handle"))
      lambda { Movie.find_in_tmdb("Inception") }.
        should raise_error(Movie::RuntimeError)
    end
  end

end