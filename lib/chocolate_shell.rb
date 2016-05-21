module ChocolateShell
  module Boundary
    def self.included(klass)
      imethods = klass.instance_methods(false)

      klass.send(:define_method, "initialize") do |value, opts = {}|
        @result = value
        @log_handler = opts[:log_handler]
        super()
      end

      klass.send(:define_method, "on_error") do |handler|
        err =
          if @method && handler.respond_to?(@method)
            handler.__send__(@method, @result, @error) || @error
          elsif @method
            @error
          end

        @result = nil if err

        [@result, err]
      end

      imethods.each do |method|
        klass.send(:define_method, "protected_#{method}") do
          return self if @failed

          begin
            @result =
              if @log_handler && @log_handler.respond_to?(method)
                @log_handler.__send__(method) do
                  __send__("original_#{method}", @result)
                end
              else
                __send__("original_#{method}", @result)
              end
          rescue => e
            @failed = true
            @error = e
            @method = method
          end

          self
        end

        klass.send(:alias_method, "original_#{method}", method)
        klass.send(:alias_method, method, "protected_#{method}")
      end
    end
  end
end
