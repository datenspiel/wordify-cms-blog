module WordifyCms
  module Blog
    module ClassDefinition

      def self.included(base)
        mock_class_definition(base)
      end

      private

      def self.mock_class_definition(included_in_klass)
        class_definition_mock = Class.new do
          attr_reader :name

          def initialize(name)
            @name = name
          end
        end.new(included_in_klass.name)
        define_method :class_definition do
          return class_definition_mock
        end
      end

    end
  end
end