module MetricAbcReport
  class Report

    attr_accessor :files, :output_file, :output_type

    def initialize(output_file = nil, output_type = 'html')
      @output_file = output_file
      @output_type = output_type
    end

    def most_complex(max_complexity = 1)
      file_names = Hash.new
      most_complex_files = []

      self.files.sort {|a, b| a.score <=> b.score}.each do |file|
        if file_names[file.name].nil? && file.score >= max_complexity
          most_complex_files << file
          file_names[file.name] = true
        end
      end

      most_complex_files.uniq
    end

    def parse(command_line_output)
      self.files = []

      command_line_output.strip.split(/\n/).each do |line|
        file_name, file_symbols, file_score = parse_line(line)
        self.files << MetricAbcReport::File.new(file_name, file_score, file_symbols)
      end

      self.files
    end

  private

    def parse_line(line)
      file_symbols = line.split(/ > /)
      file_name = file_symbols.delete_at(0).strip
      last_file_symbol = file_symbols.last
      match = last_file_symbol.match(/^(\w+): (\d+)/)
      file_score = match[2].to_i
      file_symbols[file_symbols.size - 1] = match[1]
      [file_name, file_symbols, file_score]
    end

  end
end
