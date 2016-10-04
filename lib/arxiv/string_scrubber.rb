module Arxiv
  class StringScrubber
    def self.scrub(string)
      string.gsub("\n", ' ').strip.squeeze(" ")
    end

    # On approximately Oct 2016, ArXiv seems to have converted their entire
    # site to use SSL. Old HTTP links, still work by redirecting to HTTPS.
    #
    # Unfortunately, this change is not yet reflected in their API responses
    # (e.g. their API still returns a non-SSL URL). Thus, if you try to use
    # this URL it will redirect to the new SSL URL. This can create problems
    # if the client is not expecting redirects.
    #
    # Hopefully they will update their API. Until then, this little method
    # forces `url` to use HTTPS rather than HTTP. If `url` is already HTTPS,
    # it will happily return `url` unaltered.
    #
    def self.force_ssl_url(url)
      url.sub(/^http:/, "https:")
    end
  end
end
