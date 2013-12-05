module WordifyCms
  module Blog
    module RSpec
      module SharedExamples

        shared_examples_for "handle not logged in user" do

          subject{ ActiveSupport::JSON.decode(response.body) }

          it "is not allowed to write a post" do
            expect(subject).to have_key("error")
            expect(subject["error"]).to \
                        eql("You need to sign in or sign up before continuing.")
          end

        end

        shared_examples_for "an empty response" do

          before do
            get :index, :format => "json"
          end

          subject { ActiveSupport::JSON.decode(response.body) }

          it "responds with empty array" do
            expect(subject).to be_instance_of Array
            expect(subject).to be_empty
          end

        end

      end
    end
  end
end