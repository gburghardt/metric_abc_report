module MetricAbcReport

  class FileReport
    attr_accessor :name, :score, :symbols

    def initialize(name = nil, score = nil, symbols = nil)
      @name = name
      @score = score
      @symbols = symbols
    end

    def formatted_symbol
      if @formatted_symbol.nil?
        @formatted_symbol = ''

        symbols.each do |symbol|
          if /^[A-Z]/ =~ symbol
            symbol = "::#{symbol}" if @formatted_symbol != ''
            @formatted_symbol << symbol
          else
            symbol = ".#{symbol}" if @formatted_symbol != ''
            @formatted_symbol << symbol
          end
        end
      end

      @formatted_symbol
    end

    def score_threshold_name(high= 20, medium = 10)
      if self.score >= high
        'high'
      elsif self.score >= medium
        'medium'
      else
        'low'
      end
    end

  end

end
