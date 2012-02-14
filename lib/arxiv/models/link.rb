module Arxiv
  class Link
    include HappyMapper
    attribute :url, String, tag: 'href'
    attribute :content_type, String, tag: 'type'
  end
end