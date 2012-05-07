require 'spec_helper'

describe MetricAbcReport::Report do
  before :each do
    @report = MetricAbcReport::Report.new
    @command_line_output = <<-END
      ./app/models/foo.rb > Foo > bar: 1
      ./app/models/foo.rb > Foo > zar: 3
      ./lib/module/foo/bar.rb > Module > Foo > bar: 10
    END
  end

  describe 'most_complex' do
    before :all do
      @report.parse(@command_line_output)
    end

    it 'sorts by complexity and returns all files' do
      most_complex_files = @report.most_complex
      most_complex_files.size.should == 2
      most_complex_files[0].name.should == './lib/module/foo/bar.rb'
      most_complex_files[1].name.should == './app/models/foo.rb'
    end

    it 'sorts by complexity and returns only files meeting a certain threshold' do
      pending
    end
  end

  describe 'parse' do
    it 'returns an array of files' do
      files = @report.parse(@command_line_output)

      files.size.should == 3

      files[0].name.should == './app/models/foo.rb'
      files[0].score.should == 1
      files[0].symbols.should == ['Foo', 'bar']

      files[1].name.should == './app/models/foo.rb'
      files[1].score.should == 3
      files[1].symbols.should == ['Foo', 'zar']

      files[2].name.should == './lib/module/foo/bar.rb'
      files[2].score.should == 10
      files[2].symbols.should == ['Module', 'Foo', 'bar']

      @report.files.size.should == 3
    end
  end

  describe 'parse_line' do
    it 'returns the file name, score and the symbols' do
      file_name, file_symbols, file_score = @report.send(:parse_line, './app/models/foo.rb > Foo > bar: 3')
      file_name.should == './app/models/foo.rb'
      file_score.should == 3
      file_symbols.should == ['Foo', 'bar']
    end

    it 'returns the file name, score and an array of symbols' do
      file_name, file_symbols, file_score = @report.send(:parse_line, './lib/module/foo.rb > Module > Foo > bar: 10')
      file_name.should == './lib/module/foo.rb'
      file_score.should == 10
      file_symbols.should == ['Module', 'Foo', 'bar']
    end
  end
end
