# coding: utf-8
require File.expand_path("../../spec_helper", __FILE__)

describe Configue::Merger do
  describe ".merge" do
    context "when merging a hash with another hash" do
      let(:former) do
        {
          a: {
            aa: {
              aaa: 1,
              aab: 2,
            },
            ab: {
              aba: 1,
              abb: 2,
            },
          },
        }
      end

      let(:latter) do
        {
          a: {
            aa: {
              aac: 3,
            },
            ab: {
              abc: 3,
            },
          },
          b: {
            ba: {
              baa: 1,
            },
          },
        }
      end

      let(:expected) do
        {
          a: {
            aa: {
              aaa: 1,
              aab: 2,
              aac: 3,
            },
            ab: {
              aba: 1,
              abb: 2,
              abc: 3,
            },
          },
          b: {
            ba: {
              baa: 1,
            },
          },
        }
      end

      it "returns a merged hash" do
        actual = Configue::Merger.merge(former, latter)
        expect(actual).to eq expected
      end
    end

    context "when the latter is nil" do
      let(:former) do
        {
          a: {
            aa: 1,
          },
        }
      end

      let(:expected) do
        {
          a: {
            aa: 1,
          },
        }
      end

      it "returns the former hash remaining without change" do
        actual = Configue::Merger.merge(former, nil)
        expect(actual).to eq expected
      end
    end

    context "when the former is nil" do
      let(:latter) do
        {
          a: {
            aa: 9,
          },
        }
      end

      let(:expected) do
        {
          a: {
            aa: 9,
          },
        }
      end

      it "returns the latter remaining without change" do
        actual = Configue::Merger.merge(nil, latter)
        expect(actual).to eq expected
      end
    end
  end
end
