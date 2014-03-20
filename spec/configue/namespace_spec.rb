# coding: utf-8
require File.expand_path("../../spec_helper", __FILE__)

describe "Configue::Container" do
  context "when specifing 'namespace'" do
    require "#{File.dirname(__FILE__)}/../namespace_conf"

    context "1st level" do
      it_should_behave_like "an InnerHash instance",
        NamespaceConf,
        {"pee" => ["kaa"]}
    end

    context "2nd level" do
      it_should_behave_like "an InnerHash instance",
        NamespaceConf["pee"],
        {"kaa" => ["boo"]}
    end

    context "3rd level" do
      it_should_behave_like "an InnerHash instance",
        NamespaceConf["pee"]["kaa"],
        {"boo" => ["foo", "baa", "baz"]}
    end
  end

  context "when specifing 'namespace' and 'base_namespace'" do
    require "#{File.dirname(__FILE__)}/../base_namespace_conf"

    context "1st level" do
      it_should_behave_like "an InnerHash instance",
        BaseNamespaceConf,
        {"pee" => ["kaa"]}
    end

    context "2nd level" do
      it_should_behave_like "an InnerHash instance",
        BaseNamespaceConf["pee"],
        {"kaa" => ["boo"]}
    end

    context "3rd level" do
      it_should_behave_like "an InnerHash instance",
        BaseNamespaceConf["pee"]["kaa"],
        {"boo" => ["foo", "baa", "baz", "boo", "woo", "poo"]}

      it "returns values defined in namespaced hash" do
        root = BaseNamespaceConf.query[:pee][:kaa][:boo]
        expect(root[:foo].retrieve).to eq "one"
        expect(root[:baa].retrieve).to eq "two"
        expect(root[:baz].retrieve).to eq "three"
      end
    end
  end
end
