require 'spec_helper'

describe MetricAbcReport::CsvOutput do
  before :each do
    @output_report_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixtures', 'output.csv')).to_s
    @report = MetricAbcReport::Report.new(@output_report_path, MetricAbcReport::Report::FORMAT_CSV)
    @command_line_output = <<-END
      ./app/models/foo.rb > Foo > bar: 1
      ./app/models/foo.rb > Foo > zar: 3
      ./lib/module/foo/bar.rb > Module > Foo > bar: 10
    END
  end

  describe 'most_complex' do
    it 'orders files by most complex' do
      @report.parse(@command_line_output)
      @report.render
      csv = nil

      File.open(@output_report_path, 'r') do |file|
        csv = file.read.split(/\n/)
      end

      csv.size.should == 4
      csv[0].should == 'File Name,Symbol,Score'
      csv[1].should == './lib/module/foo/bar.rb,Module::Foo.bar,10'
      csv[2].should == './app/models/foo.rb,Foo.zar,3'
      csv[3].should == './app/models/foo.rb,Foo.bar,1'
    end
  end
end
