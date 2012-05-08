require 'spec_helper'

describe MetricAbcReport::FileReport do
  describe 'formatted_symbol' do
    before :each do
      @file = MetricAbcReport::FileReport.new
    end

    it 'returns the symbol if there is only one' do
      @file.symbols = ['just_testing']
      @file.formatted_symbol.should == 'just_testing'
    end

    it 'returns a simple class and method combo' do
      @file.symbols = ['MyClass', 'my_method']
      @file.formatted_symbol.should == 'MyClass.my_method'
    end

    it 'returns a namespaced class and method combo' do
      @file.symbols = ['Module', 'Class', 'method']
      @file.formatted_symbol.should == 'Module::Class.method'
    end
  end
end
