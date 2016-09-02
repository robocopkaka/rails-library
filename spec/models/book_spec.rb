require 'rails_helper'

RSpec.describe Book, type: :model do
  it "has a valid factory" do
    expect(book).to be_valid
  end
end


  describe Book do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:isbn) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:quantity) }
    it { is_expected.to validate_presence_of(:surcharge_fee) }
  end
