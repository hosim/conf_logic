# coding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Configue::Container" do
  context "when reading a single yaml file" do
    require File.expand_path("../samples/single_yaml_conf", __FILE__)

    context "1st level" do
      it_should_behave_like "an InnerHash instance",
        SingleYamlConf,
        {"foo" => ["baa"], "pee" => ["kaa0", "kaa1"]}
    end

    context "2nd level" do
      it_should_behave_like "an InnerHash instance",
        SingleYamlConf["foo"],
        {"baa" => ["baz0", "baz1"]}
      it_should_behave_like "an InnerHash instance",
        SingleYamlConf["pee"],
        {"kaa0" => ["boo"], "kaa1" => ["boo"]}
    end
  end

  context "when reading multiple yaml files" do
    require File.expand_path("../samples/multiple_yaml_conf", __FILE__)

    context "1st level" do
      it_should_behave_like "an InnerHash instance",
        MultipleYamlConf,
        {"foo" => ["baa", "bar", "pee"]}
    end

    context "2nd level" do
      it_should_behave_like "an InnerHash instance",
        MultipleYamlConf["foo"],
        {"baa" => ["baz"], "bar" => ["ding", "tick"], "pee" => ["kaa", "boo"]}
    end

    context "3rd level" do
      it_should_behave_like "an InnerHash instance",
        MultipleYamlConf["foo"]["baa"], {"baz" => nil}
      it_should_behave_like "an InnerHash instance",
        MultipleYamlConf["foo"]["pee"], {"kaa" => nil, "boo" => nil}
      it_should_behave_like "an InnerHash instance",
        MultipleYamlConf["foo"]["bar"],
        {"ding" => ["dong", "dang"], "tick" => ["tack", "toe"]}
    end
  end

  context "when reading a single yaml with source_file" do
    require File.expand_path("../samples/single_source_conf", __FILE__)

    context "1st level" do
      it_should_behave_like "an InnerHash instance",
        SingleSourceConf,
        {"config" => ["accounts"]}
    end

    context "2nd level" do
      it_should_behave_like "an InnerHash instance",
        SingleSourceConf["config"],
        {"accounts" => ["admin_users"]}
    end
  end

  context "when loading a yaml file with an array of records" do
    let(:config) do
      source_file = File.expand_path("../samples/array_records.yml", __FILE__)
      Class.new(Configue::Container) {
        config.source_file source_file
      }
    end

    describe "first record" do
      describe ".has_key?" do
        context 'when parameter is "name"' do
          it "returns true" do
            expect(config.first).to have_key("name")
          end
        end

        context 'when parameter is "email"' do
          it "returns true" do
            expect(config.first).to have_key("email")
          end
        end

        context "when parameter is :name" do
          it "returns true" do
            expect(config.first).to have_key(:name)
          end
        end

        context "when parameter is :email" do
          it "returns true" do
            expect(config.first).to have_key(:email)
          end
        end

        context 'when parameter is "foo"' do
          it "returns false" do
            expect(config.first).not_to have_key("foo")
          end
        end

        context "when parameter is :foo" do
          it "returns false" do
            expect(config.first).not_to have_key(:foo)
          end
        end
      end
    end
  end

  context "when loading the sample multiple yaml files with an array of records" do
    let(:config) do
      source_dir = File.expand_path("../samples/multiple_array_records", __FILE__)
      Class.new(Configue::Container) {
        config.source_dir source_dir
      }
    end

    describe ".size" do
      it "returns 2" do
        expect(config.size).to eq 2
      end
    end

    describe ".first" do
      it "can respond to a `keys' message" do
        expect(config.first).to respond_to(:keys)
      end

      describe ".keys" do
        it "returns 'name' and 'fields'" do
          expect(config.first.keys).to match_array(["name", "fields"])
        end
      end

      describe ".name" do
        it "returns String value" do
          expect(config.first.name).to be_instance_of(String)
        end
      end

      describe ".fields" do
        describe ".first" do
          describe ".keys" do
            it "returns `name', `type', `default', `null' and `option'" do
              target = config.first.fields.first.keys
              expect(target).to match_array(%w[name type default null option])
            end
          end
        end
      end
    end

    describe ".select" do
      context "when select records of which `name' is `friends'" do
        let(:friends_record) do
          config.select {|item| item.name == 'friends' }
        end

        it "returns an array that has only one record" do
          expect(friends_record.size).to eq 1
        end

        describe ".first" do
          it "returns a hash node that has `name' and `fields' key" do
            expect(friends_record.first.keys).to match_array(%w[name fields])
          end

          describe ".fields" do
            let(:friends_fields) do
              friends_record.first.fields
            end

            it "return an array that has 4 records" do
              expect(friends_fields.size).to eq 4
            end
          end
        end
      end
    end
  end
end
