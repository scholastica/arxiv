require 'spec_helper'

module Arxiv
  describe Manuscript do
    before(:all) do
      @manuscript = Arxiv.get('1202.0819')
      @legacy_manuscript = Arxiv.get('math.DG/0510097v1')
    end

    describe "arxiv_url" do
      it "should fetch the link to the manuscript's page on arXiv" do
        expect(@manuscript.arxiv_url).to eql("https://arxiv.org/abs/1202.0819v1")
      end
    end

    describe "created_at" do
      it "should fetch the datetime when the manuscript was first published to arXiv" do
        expect(@manuscript.created_at).to eql(DateTime.parse("2012-02-03T21:00:00Z"))
      end
    end

    describe "updated_at" do
      it "should fetch the datetime when the manuscript was last updated" do
        expect(@manuscript.updated_at).to eql(DateTime.parse("2012-02-03T21:00:00Z"))
      end
    end

    describe "title" do
      it "should fetch the manuscript's title" do
        expect(@manuscript.title).to eql("Laser frequency comb techniques for precise astronomical spectroscopy")
      end
    end

    describe "abstract" do
      it "should fetch the manuscript's abstract" do
        expect(@manuscript.abstract).to eql("Precise astronomical spectroscopic analyses routinely assume that individual pixels in charge-coupled devices (CCDs) have uniform sensitivity to photons. Intra-pixel sensitivity (IPS) variations may already cause small systematic errors in, for example, studies of extra-solar planets via stellar radial velocities and cosmological variability in fundamental constants via quasar spectroscopy, but future experiments requiring velocity precisions approaching ~1 cm/s will be more strongly affected. Laser frequency combs have been shown to provide highly precise wavelength calibration for astronomical spectrographs, but here we show that they can also be used to measure IPS variations in astronomical CCDs in situ. We successfully tested a laser frequency comb system on the Ultra-High Resolution Facility spectrograph at the Anglo-Australian Telescope. By modelling the 2-dimensional comb signal recorded in a single CCD exposure, we find that the average IPS deviates by <8 per cent if it is assumed to vary symmetrically about the pixel centre. We also demonstrate that series of comb exposures with absolutely known offsets between them can yield tighter constraints on symmetric IPS variations from ~100 pixels. We discuss measurement of asymmetric IPS variations and absolute wavelength calibration of astronomical spectrographs and CCDs using frequency combs.")
      end
    end

    describe "comment" do
      it "should fetch the manuscript's comment" do
        expect(@manuscript.comment).to eql("11 pages, 7 figures. Accepted for publication in MNRAS")
      end
    end

    describe "revision?" do
      it "should return true if the manuscript has been revised" do
        expect(@manuscript).not_to be_revision
      end
    end

    describe "arxiv_versioned_id" do
      it "should return the unique versioned document id used by arXiv for a current manuscript" do
        expect(@manuscript.arxiv_versioned_id).to eql('1202.0819v1')
      end

      it "should return the unique versioned document id used by arXiv for a legacy manuscript" do
        expect(@legacy_manuscript.arxiv_versioned_id).to eql('math/0510097v1')
      end
    end

    describe "arxiv_id" do
      it "should return the unique document id used by arXiv for a current manuscript" do
        expect(@manuscript.arxiv_id).to eql('1202.0819')
      end

      it "should return the unique document id used by arXiv for a legacy manuscript" do
        expect(@legacy_manuscript.arxiv_id).to eql('math/0510097')
      end
    end

    describe "version" do
      it "should return the manuscript's version number for a current manuscript" do
        expect(@manuscript.version).to eql(1)
      end

      it "should return the manuscript's version number for a legacy manuscript" do
        expect(@legacy_manuscript.version).to eql(1)
      end
    end

    describe "content_types" do
      it "return an array of available content_types" do
        expect(@manuscript.content_types).to match_array(["text/html", "application/pdf"])
      end
    end

    describe "available_in_pdf?" do
      it "should return true if the manuscript is available to be downloaded in PDF" do
        expect(@manuscript).to be_available_in_pdf
      end
    end

    describe "pdf_url" do
      it "should return the url to download the manuscript in PDF format" do
        expect(@manuscript.pdf_url).to eql('https://arxiv.org/pdf/1202.0819v1.pdf')
      end
    end

    describe "authors" do
      it "should return an array of all the manuscript's authors" do
        expect(@manuscript.authors.size).to eql(5)
      end
    end

    describe "categories" do
      it "should fetch the manuscript's categories" do
        catagories = @manuscript.categories.map(&:abbreviation)
        expect(catagories).to include("astro-ph.IM", "astro-ph.CO", "astro-ph.EP")
      end
    end

    describe "primary_category" do
      it "should return the manuscript's primary category" do
        expect(@manuscript.primary_category.abbreviation).to eql("astro-ph.IM")
      end
    end

    describe "legacy_article?" do
      it "should return true if the manuscript was upload while the legacy API was still in use" do
        expect(@legacy_manuscript).to be_legacy_article
      end

      it "should return false if the manuscript was uploaded after the transition to the new API" do
        expect(@manuscript).not_to be_legacy_article
      end
    end
  end
end
