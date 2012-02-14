require 'open-uri'
require 'nokogiri'
require 'happymapper'

require 'arxiv/version'
require 'arxiv/string_scrubber'

require 'arxiv/models/author'
require 'arxiv/models/link'
require 'arxiv/models/category'
require 'arxiv/models/manuscript'

module Arxiv

  module Error
    class ManuscriptNotFound < StandardError ; end
    class MalformedId < StandardError ; end
  end

  ID_FORMAT = /^\d{4}\.\d{4}(?:v\d+)?$/

  def self.get(id)
    raise Arxiv::Error::MalformedId, "Manuscript ID format is invalid" unless id =~ ID_FORMAT

    url = ::URI.parse("http://export.arxiv.org/api/query?id_list=#{id}")
    response = ::Nokogiri::XML(open(url)).remove_namespaces!
    manuscript = Arxiv::Manuscript.parse(response.to_s, single: id)

    raise Arxiv::Error::ManuscriptNotFound, "Manuscript #{id} doesn't exist on arXiv" if manuscript.title.nil?
    manuscript
  end

end
