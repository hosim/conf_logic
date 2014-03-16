# coding: utf-8

shared_examples_for "an InnerHash instance" do |object, hash|
  describe ".has_key?" do
    context "when specifing the existing key names" do
      it "returns true" do
        hash.keys.each do |key|
          expect(object).to have_key(key)
        end
      end
    end

    context "when specifing the non-existing key names" do
      it "returns false" do
        hash.keys.each do |key|
          expect(object).not_to have_key(key.reverse)
        end
      end
    end

    context "when specifing the existing key names in symbol" do
      it "returns true" do
        hash.keys.each do |key|
          expect(object).to have_key(key.to_sym)
        end
      end
    end

    context "when specifing the non-existing key names in symbol" do
      it "returns false" do
        hash.keys.each do |key|
          expect(object).not_to have_key(key.reverse.to_sym)
        end
      end
    end
  end

  describe ".[]" do
    context "when specifing the existing key names" do
      it "returns a Hash value" do
        hash.each do |key, value|
          expect(object[key]).to be_a(Hash) if value
        end
      end

      describe "the Hash value" do
        it "has keys described in the setting(s)" do
          hash.each do |key, value|
            expect(object[key].keys).to match_array(value) if value
          end
        end
      end
    end

    context "when specifing the existing key names in symbol" do
      it "returns a Hash value" do
        hash.each do |key, value|
          expect(object[key.to_sym]).to be_a(Hash) if value
        end
      end

      describe "the Hash value" do
        it "has keys described in the setting(s)" do
          hash.each do |key, value|
            expect(object[key.to_sym].keys).to match_array(value) if value
          end
        end
      end
    end
  end

  describe ".(key_name)" do
    context "when call methods which names are existing in the setting(s)" do
      it "returns a Hash value" do
        hash.each do |key, value|
          expect(object.__send__(key)).to be_a(Hash) if value
        end
      end

      describe "the Hash value" do
        it "has keys described in the setting(s)" do
          hash.each do |key, value|
            next unless value
            actual = object.__send__(key)
            expect(actual.keys).to match_array(value)
          end
        end
      end
    end
  end
end
