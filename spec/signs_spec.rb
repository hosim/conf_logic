# coding: utf-8
require File.expand_path("../spec_helper", __FILE__)

describe "Configue::Container" do
  context "when reading a yaml file with keys included signs" do
    require File.expand_path("../signs_conf", __FILE__)

    context "1st level" do
      describe ".keys" do
        it "returns keys described in the setting file" do
          actual = SignsConf.keys
          expect(actual).to match_array(["a top key with some spaces", "!@#$%^&*()_+"])
        end
      end

      describe ".[]" do
        it "returns a value associated with the parameter" do
          actual = SignsConf["a top key with some spaces"]
          expected = {"a key with some spaces" => "OK"}
          expect(actual).to eq expected

          actual = SignsConf["!@#$%^&*()_+"]
          expected = {"+_)(*&^%$#@!" => "OK"}
          expect(actual).to eq expected
        end
      end
    end

    context "2nd level" do
      describe ".keys" do
        it "returns keys described in the setting file" do
          actual = SignsConf["a top key with some spaces"].keys
          expect(actual).to match_array(["a key with some spaces"])

          actual = SignsConf["!@#$%^&*()_+"].keys
          expect(actual).to match_array(["+_)(*&^%$#@!"])
        end
      end

      describe ".[]" do
        it "returns a value associated with the parameter" do
          actual = SignsConf["a top key with some spaces"]["a key with some spaces"]
          expect(actual).to eq "OK"

          actual = SignsConf["!@#$%^&*()_+"]["+_)(*&^%$#@!"]
          expect(actual).to eq "OK"
        end
      end
    end
  end
end
