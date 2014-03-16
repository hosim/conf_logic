# coding: utf-8
require File.expand_path(File.dirname(__FILE__) + "/spec_helper")

describe "Configue::Container" do
  context "when reading a single yaml file" do
    require "#{File.dirname(__FILE__)}/single_yaml_conf"

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

    describe ".path?" do
      context "when specifing an existing path" do
        it "returns true" do
          actual = SingleYamlConf.path?("pee.kaa1.boo")
          expect(actual).to be_true
        end
      end

      context "when specifing a non-existing path" do
        it "returns false" do
          actual = SingleYamlConf.path?("pee.kaa.boo")
          expect(actual).to be_false
        end
      end
    end
  end

  context "when reading multiple yaml files" do
    require "#{File.dirname(__FILE__)}/multiple_yaml_conf"

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
end
