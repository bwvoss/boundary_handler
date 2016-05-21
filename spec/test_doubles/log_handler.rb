module TestDoubles
  class LogHandler
    def initialize(logger)
      @logger = logger
    end

    def add_1
      @logger << 'before add_1'
      result = yield
      @logger << 'after add_1'

      result
    end
  end
end
