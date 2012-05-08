module MetricAbcReport
  class Output
    attr_accessor :report

    def initialize(report)
      @report = report
    end

    def most_complex
      @most_complex_files = @report.most_complex
    end
  end
end
