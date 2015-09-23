require 'spec_helper'

module Arxiv
  RSpec::Matchers.define :fetch do |expected|
    match do |actual|
      actual.is_a?(Arxiv::Manuscript) && actual.title == expected
    end
  end

  describe "get" do
    context "when using the current arXiv id format" do
      it "should fetch a manuscript when passed an id" do
        expect(Arxiv.get('1202.0819')).to fetch("Laser frequency comb techniques for precise astronomical spectroscopy")
      end

      it "should fetch a manuscript when passed a valid id with a version number" do
        expect(Arxiv.get('1202.0819v1')).to fetch("Laser frequency comb techniques for precise astronomical spectroscopy")
      end

      it "should fetch a manuscript when passed full URL" do
        expect(Arxiv.get('http://arxiv.org/abs/1202.0819')).to fetch("Laser frequency comb techniques for precise astronomical spectroscopy")
      end
    end

    context "when using the legacy arXiv id format" do
      it "should fetch a manuscript when passed an id" do
        expect(Arxiv.get('math.DG/0510097')).to fetch("The differential topology of loop spaces")
      end

      it "should fetch a manuscript when passed a valid id with a version number" do
        expect(Arxiv.get('math.DG/0510097v1')).to fetch("The differential topology of loop spaces")
      end

      it "should fetch a manuscript when passed full URL" do
        expect(Arxiv.get('http://arxiv.org/abs/math.DG/0510097')).to fetch("The differential topology of loop spaces")
      end
    end

    context "when something goes wrong" do
      it "should raise an error if the manuscript cannot be found on arXiv" do
        expect { Arxiv.get('1234.1234') }.to raise_error(Arxiv::Error::ManuscriptNotFound)
      end

      it "should raise an error if the manuscript has an incorrectly formatted id" do
        expect { Arxiv.get('cond-mat0709123') }.to raise_error(Arxiv::Error::MalformedId)
      end
    end

  end
end
