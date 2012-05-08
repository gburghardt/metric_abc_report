require 'erb'

module MetricAbcReport
  class HtmlOutput < Output

    def most_complex
      super
      create_general_info
      render
    end

    private

    def create_general_info
      @date_created = Time.now
      @high_score = 20
      @medium_score = 10
      score_total = 0

      @most_complex_files.each do |f|
        score_total += f.score
        @most_complex = f if @most_complex.nil? || f.score > @most_complex.score
        @least_complex = f if @least_complex.nil? || f.score < @least_complex.score
      end

      @average_complexity_score = score_total / @most_complex_files.size
    end

    def read_template_file
      File.open(File.expand_path(File.join(__FILE__, '..', 'views', 'report.html.erb'))).read
    end

    def render
      rhtml = ERB.new(read_template_file)
      File.open(self.report.output_file, 'w') { |io| io.puts(rhtml.result(binding)) }
      nil
    end

  end
end
