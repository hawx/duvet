require_relative 'helper'

describe Duvet do

  before  { Coverage.stubs(:start) }
  subject { Duvet.dup }

  describe '#start' do
    it 'makes sure :filter is a regexp' do
      subject.start :filter => 'str'
      subject.opts[:filter].must_be_kind_of Regexp
    end

    it 'starts Coverage' do
      Coverage.expects(:start)
      subject.start
    end
  end

  describe '#result' do
    it 'filters the results' do
      Coverage.expects(:result).returns({'a/b.c' => [], 'a/e.f' => [], 'g/h.i' => []})
      subject.start :filter => 'a/e'

      subject.result.map(&:path).map(&:to_s).must_equal ['a/e.f']
    end

    it 'returns a Covs instance' do
      Coverage.stubs(:result).returns({'a/b.c' => []})
      subject.result.must_be_kind_of Duvet::Covs
    end
  end

  describe '#format' do
    it 'renders a file from the data and template given' do
      Pathname.any_instance.stubs(:read).returns("The magic number is <%= a %>")
      r = subject.format({a: 1}, 'template.erb')
      r.must_equal "The magic number is 1"
    end
  end

  describe '#write' do
    it 'formats then writes a file' do
      formatted = Object.new
      data = {file: {url: 'somewhere/file.html'}}
      subject.expects(:format).with(data, 'template').returns(formatted)
      subject.expects(:write_file).with(formatted, 'somewhere/file.html')

      subject.write data, 'template'
    end
  end

  describe '#write_file' do
    it 'writes a file' do
      File.expects(:open).with(Pathname.new('cov/somewhere/file.html'), 'w')
      subject.write_file 'text', 'somewhere/file.html'
    end
  end

  describe '#write_resources' do
    it 'writes the resources' do
      subject.stubs(:write_file)
      4.times { subject.expects(:write_file) }

      subject.write_resources
    end
  end

  describe '#finish' do
    it 'makes the directory, writes the results and resources' do
      FileUtils.expects(:mkdir_p).with(subject.opts[:dir])
      obj = mock()
      subject.expects(:result).returns(obj)
      obj.expects(:write)
      subject.expects(:write_resources)

      subject.finish
    end
  end

end
