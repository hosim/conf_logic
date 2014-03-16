# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Configue::Container" do
  context "when reading a single yaml file" do
    require "#{File.dirname(__FILE__)}/single_yaml_conf"

    describe ".[]" do
      context "when specifing the root keys in the yaml" do
        it "returns a Hash value" do
          expect(SingleYamlConf["foo"]).to be_a(Hash)
          expect(SingleYamlConf["pee"]).to be_a(Hash)
        end

        describe "the Hash value (2nd level)" do
          subject { SingleYamlConf["foo"] }

          it "has keys described in the yaml" do
            expect(subject).to have_key("baa")
            expect(subject.keys.size).to be 1
          end

          describe "the Hash value (3rd level)" do
            subject { SingleYamlConf["foo"]["baa"] }

            it "has keys described in the yaml" do
              expect(subject).to have_key("baz0")
              expect(subject).to have_key("baz1")
              expect(subject.keys.size).to be 2
            end
          end
        end
      end

      context "when specifing the existing root key in symbol" do
        it "returns a Hash value" do
          expect(SingleYamlConf[:foo]).to be_a(Hash)
          expect(SingleYamlConf[:pee]).to be_a(Hash)
        end

        describe "the Hash value" do
          subject { SingleYamlConf[:foo] }

          it "has a key described in the yaml" do
            expect(subject).to have_key(:baa)
            expect(subject.keys.size).to be 1
          end

          describe "the Hash value (3rd level)" do
            subject { SingleYamlConf[:foo][:baa] }

            it "has keys described in the yaml" do
              expect(subject).to have_key(:baz0)
              expect(subject).to have_key(:baz1)
              expect(subject.keys.size).to be 2
            end
          end
        end
      end
    end

    describe ".(key)" do
      context "when call a method which name is the root key in the yaml" do
        it "returns a Hash value" do
          expect(SingleYamlConf.foo).to be_a(Hash)
          expect(SingleYamlConf.pee).to be_a(Hash)
        end

        describe "the Hash value (2nd level)" do
          subject { SingleYamlConf.foo }

          it "has methods which names are name of keys described in the yaml" do
            expect(subject).to respond_to(:baa)
          end

          describe "the Hash value (3rd level)" do
            subject { SingleYamlConf.foo.baa }

            it "has methods which names are name of keys described in the yaml" do
              expect(subject).to respond_to(:baz0)
              expect(subject).to respond_to(:baz1)
            end
          end
        end
      end
    end
  end

  context "when reading multiple yaml files" do
    require "#{File.dirname(__FILE__)}/multiple_yaml_conf"

    describe ".[]" do
      context "when specifing the root keys in the yaml" do
        it "return a Hash value" do
          expect(MultipleYamlConf["foo"]).to be_a(Hash)
        end

        describe "the Hash value (2nd level)" do
          subject { MultipleYamlConf["foo"] }

          it "has keys described in the yaml files" do
            expect(subject.keys).to match_array(["baa", "bar", "pee"])
          end

          describe "the Hash value (3rd level)" do
            subject do
              ["baa", "bar", "pee"].map {|k|
                MultipleYamlConf["foo"][k]
              }
            end

            it "has keys described in the yaml files" do
              expect(subject[0]).to have_key("baz")

              expect(subject[1]).to have_key("ding")
              expect(subject[1]).to have_key("tick")

              expect(subject[2]).to have_key("kaa")
              expect(subject[2]).to have_key("boo")
            end
          end
        end
      end
    end
  end
end
