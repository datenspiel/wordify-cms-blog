module WordifyCms
  module Blog
    module Attributeable

      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
      end

      module ClassMethods

        def dasherize_attributes(*attributes)
          attributes.each do |attribute|
            define_method "dasherized_#{attribute}" do
              self.send(attribute).gsub(/[\s]+/, "_").dasherize
            end
          end
        end

      end

    end
  end
end