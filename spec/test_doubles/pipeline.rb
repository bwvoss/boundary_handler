module TestDoubles
  class Pipeline
    def blow_up
      raise
    end

    def custom_blow_up
      raise
    end

    def not_handled
      raise
    end

    def nil_on_handler
      raise
    end

    def add_1(number)
      number + 1
    end

    def add_2(number)
      number + 2
    end

    def times_3(number)
      number * 3
    end

    include ChocolateShell::Boundary
  end
end
