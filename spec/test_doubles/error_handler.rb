module TestDoubles
  class ErrorHandler
    class << self
      def blow_up(data, error)
        :default
      end

      def nil_on_handler(data, error)
      end

      def custom_blow_up(data, error)
        if data == {}
          :extra
        else
          :custom
        end
      end
    end
  end
end
