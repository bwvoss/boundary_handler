require 'chocolate_shell'
require 'test_doubles/pipeline'
require 'test_doubles/error_handler'
require 'test_doubles/log_handler'

describe ChocolateShell::Boundary do
  let(:logger) { [] }

  let(:test_pipeline) do
    TestDoubles::Pipeline.new(1, log_handler: TestDoubles::LogHandler.new(logger))
  end

  let(:error_handler) { TestDoubles::ErrorHandler }

  it 'returns a result' do
    result, error = test_pipeline
      .add_1
      .on_error(error_handler)

    expect(result).to eq(2)
  end

  it 'method chains' do
    result, error = test_pipeline
      .add_1
      .add_2
      .times_3
      .on_error(error_handler)

    expect(result).to eq(12)
  end

  context 'error handling' do
    it 'returns an error' do
      result, error = test_pipeline
      .blow_up
      .on_error(error_handler)

      expect(error).to eq(:default)
    end

    it 'returns an custom key' do
      result, error = test_pipeline
      .custom_blow_up
      .on_error(error_handler)

      expect(error).to eq(:custom)
    end

    it 'returns an custom i18n key found with extra data' do
      result, error = TestDoubles::Pipeline.new({})
      .custom_blow_up
      .on_error(error_handler)

      expect(error).to eq(:extra)
    end

    it 'returns the error itself if the method is not defined on the handler' do
      result, error = test_pipeline
      .not_handled
      .on_error(error_handler)

      expect(error).to be_kind_of(ArgumentError)
    end

    it 'returns the error itself if the method is defined but returns nil' do
      result, error = test_pipeline
      .nil_on_handler
      .on_error(error_handler)

      expect(error).to be_kind_of(ArgumentError)
    end

    it 'does not return partial results when errors occur' do
      result, error = test_pipeline
      .add_1
      .not_handled
      .on_error(error_handler)

      expect(result).to be_nil
    end
  end

  context 'logging' do
    it 'does nothing if no method defined' do
      result, error = test_pipeline
        .add_2
        .on_error(error_handler)

      expect(error).to be_nil
      expect(result).to eq(3)
    end

    it 'logs data around the execution' do
      result, error = test_pipeline
        .add_1
        .on_error(error_handler)

      expect(error).to be_nil
      expect(result).to eq(2)
      expect(logger).to eq(['before add_1', 'after add_1'])
    end
  end
end
