require "rails_helper"

describe PasswordChecker do
  describe "#accepted?" do
    context "when the password is correct" do
      let(:part1) { File.read("spec/data/password_part1.txt").strip }
      let(:part2) { File.read("spec/data/password_part2.txt").strip }
      let(:part3) { File.read("spec/data/password_part3.txt").strip }

      subject { described_class.new(part1 + part2 + part3) }

      before do
        stub_request(:get, "https://sublimia.nl/~crome/password_part2.txt").
                            to_return(status: 200, body: part2)
      end

      skip "returns true" do
        expect(subject.accepted?).to be true
      end
    end
  end
end

