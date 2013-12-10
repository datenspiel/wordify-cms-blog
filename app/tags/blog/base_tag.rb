module WordifyCms
  module Blog
    module Blocks

      class Base < WordifyCms::Block

        def self.collection(name)
          define_method :collection_context do
            return name
          end
        end

      end

    end
  end
end