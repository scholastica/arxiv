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

  def self.get(id)
    url = ::URI.parse("http://export.arxiv.org/api/query?id_list=#{id}")
    response = ::Nokogiri::XML(open(url)).remove_namespaces!
    manuscript = Arxiv::Manuscript.parse(response.to_s, single: id)
  end

end
