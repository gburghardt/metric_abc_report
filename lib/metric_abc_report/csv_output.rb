module MetricAbcReport
  class CsvOutput < Output
    def most_complex
      super

      File.open(self.report.output_file, 'w') do |io|
        io.puts 'File Name,Symbol,Score'

        @most_complex_files.each do |file|
          io.puts "#{file.name},#{file.formatted_symbol},#{file.score}"
        end
      end
    end
  end
end
