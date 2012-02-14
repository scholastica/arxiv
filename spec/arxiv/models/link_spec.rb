require 'spec_helper'

module Arxiv
  describe Link do
    before(:all) { @link = Arxiv.get('1202.0819').links.last }

    describe "content_type" do
      it "should fetch the link's content type" do
        @link.content_type.should == 'application/pdf'
      end
    end

    describe "url" do
      it "should fetch the link's url" do
        @link.url.should == 'http://arxiv.org/pdf/1202.0819v1'
      end
    end

  end
end