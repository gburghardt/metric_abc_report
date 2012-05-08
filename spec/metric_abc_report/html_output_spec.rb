require 'spec_helper'

describe MetricAbcReport::HtmlOutput do
  before :each do
    @output_report_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'fixtures', 'output.html')).to_s
    @report = MetricAbcReport::Report.new(@output_report_path)
    @command_line_output = <<-END
      ./app/models/foo.rb > Foo > bar: 1
      ./app/models/foo.rb > Foo > zar: 3
      ./lib/module/foo/bar.rb > Module > Foo > bar: 10
      ./app/controllers/blogs_controller.rb > BlogsController > index: 35
    END
  end

  it 'renders the most complex files' do
    @report.parse(@command_line_output)
    @report.render
    File.exists?(@output_report_path)
  end
end
