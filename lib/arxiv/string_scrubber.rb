module Arxiv
  class StringScrubber
     def self.scrub(string)
      string.gsub("\n", ' ').strip.squeeze(" ")
    end
  end
end
