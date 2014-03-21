# coding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Configue::Container" do
  context "when a top key is 'config' in the setting files" do
    require File.expand_path("../config_conf", __FILE__)

    context "1st level" do
      it_should_behave_like "an InnerHash instance",
        ConfigConf,
        {"config" => ["accounts"]}
    end

    context "2nd level" do
      it_should_behave_like "an InnerHash instance",
        ConfigConf["config"],
        {"accounts" => ["admin_users", "test_users"]}
    end
  end
end
