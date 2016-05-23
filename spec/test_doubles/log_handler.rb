module TestDoubles
  class LogHandler
    def initialize(logger)
      @logger = logger
    end

    def add_1(current_value)
      @logger << 'before add_1'
      result = yield
      @logger << 'after add_1'

      result
    end

    def add_2(current_value)
      @logger << current_value
      yield
    end
  end
end
