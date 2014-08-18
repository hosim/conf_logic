# coding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Configue::Container" do
  context "when ERB tags are in the setting file" do
    require File.expand_path("../samples/single_erb_yaml_conf", __FILE__)

    context "1st level" do
      it "has keys `foo', `baa', `baz'" do
        expect(SingleErbYamlConf.keys).to eq ["foo", "baa", "baz"]
      end
    end

    context "2nd level" do
      it "has an array `pee', `kaa', `boo' as `foo'" do
        expect(SingleErbYamlConf.foo).to eq ["pee", "kaa", "boo"]
      end
    end
  end
end
