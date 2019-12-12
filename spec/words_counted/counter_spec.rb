# -*- coding: utf-8 -*-
require_relative "../spec_helper"

module WordsCounted
  describe Counter do
    let(:counter) do
      Counter.new(tokens)
    end
    let(:tokens) do
      WordsCounted::Tokeniser.new("one three three three woot woot").tokenise
    end

    describe "#initialize" do
      it "sets @tokens" do
        expect(counter.instance_variables).to include(:@tokens)
      end
    end

    describe "#token_count" do
      subject(:token_count) { counter.token_count }

      let(:expected) { 6 }

      it "returns the correct number of tokens" do
        expect(token_count).to eq(expected)
      end
    end

    describe "#uniq_token_count" do
      subject(:uniq_token_count) { counter.uniq_token_count }

      let(:expected) { 3 }

      it "returns the number of unique token" do
        expect(uniq_token_count).to eq(expected)
      end
    end

    describe "#char_count" do
      subject(:char_count) { counter.char_count }

      let(:expected) { 26 }

      it "returns the correct number of chars" do
        expect(char_count).to eq(expected)
      end
    end

    describe "#token_frequency" do
      subject(:token_frequency) { counter.token_frequency }

      let(:expected) do
        [['three', 3], ['woot', 2], ['one', 1]]
      end

      it "returns a two-dimensional array where each member array is a token and its frequency in descending order" do
        expect(token_frequency).to eq(expected)
      end
    end

    describe "#token_lengths" do
      subject(:token_lengths) { counter.token_lengths }

      let(:expected) do
        [['three', 5], ['woot', 4], ['one', 3]]
      end

      it "returns a two-dimensional array where each member array is a token and its length in descending order" do
        expect(token_lengths).to eq(expected)
      end
    end

    describe "#token_density" do
      subject(:token_density) { counter.token_density }

      let(:expected) do
        [['three', 0.5], ['woot', 0.33], ['one', 0.17]]
      end

      it "returns a two-dimensional array where each member array is a token and its density in descending order" do
        expect(token_density).to eq(expected)
      end

      context 'a precision is provided' do
        subject(:token_density) { counter.token_density(precision: 4) }

        let(:expected) do
          [['three', 0.5], ['woot', 0.3333], ['one', 0.1667]]
        end

        it "accepts a precision" do
          expect(counter.token_density(precision: 4)).to eq(expected)
        end
      end
    end

    describe "#most_frequent_tokens" do
      subject(:most_frequent_tokens) { counter.most_frequent_tokens }

      let(:expected) do
        { 'three' => 3 }
      end

      it "returns a hash of the tokens with the highest frequency, where each key a token, and each value is its frequency" do
        expect(most_frequent_tokens).to eq(expected)
      end
    end

    describe "#longest_tokens" do
      subject(:longest_tokens) { counter.longest_tokens }

      let(:expected) do
        { 'three' => 5 }
      end

      it "returns a hash of the tokens with the highest length, where each key a token, and each value is its length" do
        expect(longest_tokens).to eq(expected)
      end
    end
  end
end
