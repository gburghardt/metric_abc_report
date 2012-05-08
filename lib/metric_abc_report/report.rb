module MetricAbcReport
  class Report

    FORMAT_HTML = 'html'
    FORMAT_CSV = 'csv'

    attr_accessor :files, :output_file, :output_type

    def initialize(output_file = nil, output_type = 'html')
      @output_file = output_file
      @output_type = output_type
    end

    def most_complex(max_complexity = 1)
      file_symbols = Hash.new
      most_complex_files = []

      self.files.sort {|a, b| b.score <=> a.score}.each do |file|
        most_complex_files << file if file.score >= max_complexity
      end

      most_complex_files
    end

    def parse(command_line_output)
      self.files = []

      command_line_output.strip.split(/\n/).each do |line|
        file_name, file_symbols, file_score = parse_line(line)
        self.files << MetricAbcReport::FileReport.new(file_name, file_score, file_symbols)
      end

      self.files
    end

    def render
      view.most_complex
      puts "Report saved in #{self.output_file}"
    end

  private

    def parse_line(line)
      file_symbols = line.split(/ > /)
      file_name = file_symbols.delete_at(0).strip
      last_file_symbol = file_symbols.last
      match = last_file_symbol.match(/^([^:]+): (\d+)/)
      raise "Could not match line: \"#{line}\"" if match.nil?
      raise "Could not match the method name: \"#{line}\"" if match[1].nil?
      raise "Could not match the score: \"#{line}\"" if match[2].nil?
      file_score = match[2].to_i
      file_symbols[file_symbols.size - 1] = match[1]
      [file_name, file_symbols, file_score]
    end

    def view
      if @view.nil?
        if self.output_type == FORMAT_CSV
          @view = MetricAbcReport::CsvOutput.new(self)
        else
          @view = MetricAbcReport::HtmlOutput.new(self)
        end
      end

      @view
    end

  end
end
