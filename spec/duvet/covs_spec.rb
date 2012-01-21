require_relative '../helper'

describe Duvet::Covs do

  let(:files) {
    {
      'lib/duvet.rb' => [3, 2, 1, 0, nil],
      'lib/duvet/cov.rb' => [nil, nil, 0, 1, 2]
    }
  }

  subject { Duvet::Covs.from_data files }

  describe '.from_data' do
    it 'converts data to Cov instances' do
      subject.each do |cov|
        cov.must_be_kind_of Duvet::Cov
      end
    end
  end

  describe '#report' do
    it 'creates a report' do
      subject.report.must_equal <<EOS
lib/duvet.rb
  total: 60.00%
  code:  75.00%

lib/duvet/cov.rb
  total: 40.00%
  code:  66.67%

EOS
    end
  end

  describe '#data' do
    it 'populates the data' do
      subject.data.must_include :files
    end
  end

  describe '#write' do
    it 'writes the index and individual covs' do
      subject.each {|i| i.expects(:write) }
      Duvet.expects(:write).with(subject.data, 'html/index.erb')

      subject.write
    end

    it 'warns if no coverage to write' do
      empty = Duvet::Covs.new
      -> { empty.write }.must_output nil, "No files to create coverage for.\n"
    end
  end

end
