module MetricAbcReport

  class FileReport
    attr_accessor :name, :score, :symbols

    def initialize(name = nil, score = nil, symbols = nil)
      @name = name
      @score = score
      @symbols = symbols
    end

    def self.score_threshold_name(score, high = 20, medium = 10)
      if score >= high
        'high'
      elsif score >= medium
        'medium'
      else
        'low'
      end
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

    def score_threshold_name(high = 20, medium = 10)
      self.class.score_threshold_name(self.score, high, medium)
    end

  end

end
