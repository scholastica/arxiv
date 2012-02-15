require 'spec_helper'

module Arxiv

  RSpec::Matchers.define :fetch_valid_manuscript do |expected|
    match do |actual|
      expected_title = "Laser frequency comb techniques for precise astronomical spectroscopy"
      actual.is_a?(Arxiv::Manuscript) && actual.title == expected_title
    end
  end

  describe "get" do
    it "should fetch a manuscript when passed a valid id" do
      Arxiv.get('1202.0819').should fetch_valid_manuscript
    end

    it "should fetch a manuscript when passed a valid id with a version number" do
      Arxiv.get('1202.0819v1').should fetch_valid_manuscript
    end

    it "should fetch a manuscript when passed full URL for a manuscript" do
      Arxiv.get('http://arxiv.org/abs/1202.0819').should fetch_valid_manuscript
    end

    context "errors" do
      it "should raise a manuscript not found error when the manuscript cannot be found on arXiv" do
        lambda { Arxiv.get('1234.1234') }.should raise_error(Arxiv::Error::ManuscriptNotFound)
      end
      it "should raise a malformed id error when the manuscript id has an incorrect format" do
        lambda { Arxiv.get('cond-mat0709123') }.should raise_error(Arxiv::Error::MalformedId)
      end
    end

  end

end
