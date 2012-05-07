module MetricAbcReport

  class Output

    attr_accessor :report

    def initialize(report)
      @report = report
    end

    def most_complex
      @files = @report.most_complex
    end

  end

end
