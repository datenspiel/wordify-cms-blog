module WordifyCms
  module RSpec
    module Tags

      def mock_controller
        let(:my_controller_class) do
          Class.new(WordifyCms::WordifyController) do
          end
        end
        let(:my_controller){ my_controller_class.new }
      end

    end
  end
end