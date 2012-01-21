module Duvet

  # A list of Cov objects.
  class Covs < Array

    # Creates a new Covs array from the data given by Coverage.
    #
    # @param data [Hash] Data given by Coverage
    def self.from_data(data)
      new data.map {|p,c| Cov.new(p, c) }
    end

    # @return [String] A simple text report of coverage
    def report
      map(&:report).join("\n") + "\n"
    end

    # @return [Hash] Data used for templating
    def data
      {
        files: map(&:data),
        file: {
          url: 'index.html'
        }
      }
    end

    # Writes the index and individual files.
    def write
      warn "No files to create coverage for." if empty?

      each &:write
      Duvet.write data, 'html/index.erb'
    end

  end
end
