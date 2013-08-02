require 'spec_helper'

describe Movie do

  before { @movie = Movie.new(title: "My New Movie", rating: "PG-13",
    release_date: "2004-01-03", ) }

  subject { @movie }

  it { should respond_to :title }
  it { should respond_to :rating }
  it { should respond_to :release_date }
  it { should respond_to :description }
  it { should respond_to :grandfathered? }
  it { should respond_to :released_1930_or_later }
  it { should respond_to :reviews }
  it { should respond_to :moviegoers }

  describe "release date attr" do
    describe "should be invalid if release date is before 1930" do
      before { @movie.release_date = "1929-06-06" }
      it { should_not be_valid }
    end
  end

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
        should raise_error(RuntimeError)
    end
  end

  describe "potato average method" do
    before :each do
      @new_movie = FactoryGirl.create(:movie)
    end
    describe "for a movie with reviews" do
      before :each do
        @moviegoers = []
        3.times do |i|
          @moviegoers[i] = FactoryGirl.create(:moviegoer)
        end
        @moviegoers[0].reviews << @new_movie.reviews.build(potatoes: 4)
        @moviegoers[1].reviews << @new_movie.reviews.build(potatoes: 4)
        @moviegoers[2].reviews << @new_movie.reviews.build(potatoes: 5)
      end
      it "should return the average of the potatoes from the reviews" do
        @new_movie.potato_average.should == 4.3
      end
    end

    describe "for a movie without reviews" do
      it "should return 0.0" do
        @new_movie.potato_average.should == 0.0
      end
    end
  end

end