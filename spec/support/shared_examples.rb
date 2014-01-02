module WordifyCms
  module Blog
    module RSpec
      module SharedExamples

        shared_examples_for "user is not logged in" do

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

        shared_examples_for "having a class definition" do |subject_name|
          describe "#class_definition" do

            let(:class_definition){ subject.class_definition }

            it "provides #name" do
              expect(class_definition).to respond_to(:name)
            end

            describe "#name" do

              it "is the #{subject_name} class name" do
                expect(class_definition.name).to eq subject.class.name
              end

            end

          end
        end

      end
    end
  end
end