module Arxiv
  class Manuscript
    include HappyMapper

    tag 'entry'
    element :arxiv_url, StringScrubber, tag: 'id', parser: :force_ssl_url
    element :created_at, DateTime, tag: 'published'
    element :updated_at, DateTime, tag: 'updated'
    element :title, StringScrubber, parser: :scrub
    element :summary, StringScrubber, parser: :scrub
    element :comment, StringScrubber, parser: :scrub
    has_one :primary_category, Category
    has_many :categories, Category
    has_many :authors, Author
    has_many :links, Link

    alias :abstract :summary

    def revision?
      created_at != updated_at
    end

    def legacy_article?
      arxiv_url =~ Arxiv::LEGACY_URL_FORMAT
    end

    def arxiv_id
      arxiv_versioned_id.match(/([^v]+)v\d+$/)[1]
    end

    def arxiv_versioned_id
      if legacy_article?
        arxiv_url.match(/(#{Arxiv::LEGACY_URL_FORMAT})/)[1]
      else
        arxiv_url.match(/(#{Arxiv::CURRENT_URL_FORMAT})/)[1]
      end
    end

    def version
      arxiv_url.match(/v(\d+)$/)[1].to_i
    end

    def content_types
      links.map(&:content_type).compact.delete_if { |t| t =~ /^\s*$/ }
    end

    def available_in_pdf?
      content_types.any? { |type| type == "application/pdf" }
    end

    def pdf_url
      if available_in_pdf?
        links.find { |l| l.content_type == "application/pdf" }.url
      end
    end
  end
end
