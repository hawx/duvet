require_relative '../helper'

describe Duvet::Cov do

  let(:lines) { [5, 2, nil, 2, 4, 3, 0, 0, 0, nil] }
  subject { Duvet::Cov.new('lib/duvet.rb', lines) }

  describe '#path' do
    it 'returns the cleaned path' do
      cov = Duvet::Cov.new(Dir.pwd + '/test.rb', [])
      cov.path.must_equal Pathname.new('test.rb')
    end
  end

  describe '#lines' do
    it 'returns the passed coverage data' do
      subject.lines.must_equal lines
    end
  end

  describe '#code_lines' do
    it 'returns lines which can be exectued' do
      subject.code_lines.must_equal [5, 2, 2, 4, 3, 0, 0, 0]
    end
  end

  describe '#ran_lines' do
    it 'returns lines which were executed' do
      subject.ran_lines.must_equal [5, 2, 2, 4, 3]
    end
  end


  describe '#total_coverage' do
    it 'returns the ratio of lines which were executed' do
      subject.total_coverage.must_equal 0.5
    end
  end

  describe '#code_coverage' do
    it 'returns the ratio of executable lines which were executed' do
      subject.code_coverage.must_equal 0.625
    end
  end

  describe '#percent' do
    it 'returns a number as a 4-digit (ie. ??.??) percentage' do
      subject.percent(0.123456789).must_equal "12.35%"
    end
  end

  describe '#report' do
    it 'generates a simple textual report of coverage' do
      subject.report.must_equal <<EOS
lib/duvet.rb
  total: 50.00%
  code:  62.50%
EOS
    end
  end

  describe '#data' do
    it 'contains the necessary template data' do
      subject.path.stubs(:readlines).returns("code and code and code")

      subject.data.must_equal file: {
        path:       'lib/duvet.rb',
        url:        'lib/duvet.html',
        root:       '../',
        source:     'code and code and code',
      },
      lines: {
        total: 10,
        code:  8,
        ran:   5
      },
      coverage: {
        code:  '62.50%',
        total: '50.00%',
        lines: lines
      }
    end
  end

  describe '#write' do
    it 'writes the file' do
      Duvet.expects(:write).with(subject.data, 'html/file.erb')
      subject.write
    end
  end
end
