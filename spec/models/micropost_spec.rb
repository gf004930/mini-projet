# == Schema Information
#
# Table name: microposts
#
#  id               :integer          not null, primary key
#  content          :string(255)
#  user_id          :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  title            :string(255)
#  post_type        :string(255)
#  publication_name :string(255)
#  year             :integer
#  month            :integer
#  notes            :string(255)
#

require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(title: "title", post_type: "journal", publication_name: "Publication", month: "1", year: "2013", content: "Lorem ipsum", notes: "All notes about publication") }

  subject { @micropost }

  it { should respond_to(:title) }
  it { should respond_to(:post_type) }
  it { should respond_to(:publication_name) }
  it { should respond_to(:month) }
  it { should respond_to(:year) }
  it { should respond_to(:content) }
  it { should respond_to(:notes) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: user.id)
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end    
  end

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @micropost.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @micropost.content = "a" * 301 }
    it { should_not be_valid }
  end

  describe "with blank title" do
    before { @micropost.title = " " }
    it { should_not be_valid }
  end

  describe "with title that is too long" do
    before { @micropost.title = "a" * 81 }
    it { should_not be_valid }
  end

  describe "with post_type other than conference or journal" do
    before { @micropost.post_type = "a" * 10 }
    it { should_not be_valid }
  end

  describe "with post_type as journal" do
    before { @micropost.post_type = "journal" }
    it { should be_valid }
  end

  describe "with post_type as conference" do
    before { @micropost.post_type = "conference" }
    it { should be_valid }
  end

  describe "with blank publication_name" do
    before { @micropost.publication_name = " " }
    it { should_not be_valid }
  end

  describe "with publication_name that is too long" do
    before { @micropost.publication_name = "a" * 81 }
    it { should_not be_valid }
  end

  describe "with month that is too low" do
    before { @micropost.month = "0" }
    it { should_not be_valid }
  end

  describe "with month that is too high" do
    before { @micropost.month = "13" }
    it { should_not be_valid }
  end

  describe "with month in the bounds" do
    before { @micropost.month = "6" }
    it { should be_valid }
  end

  describe "with year that is too low" do
    before { @micropost.year = "1949" }
    it { should_not be_valid }
  end

  describe "with year that is too high" do
    before { @micropost.year = "3001" }
    it { should_not be_valid }
  end

  describe "with year in the bounds" do
    before { @micropost.year = "2000" }
    it { should be_valid }
  end

  describe "with blank notes" do
    before { @micropost.notes = " " }
    it { should_not be_valid }
  end

  describe "with notes that are too long" do
    before { @micropost.notes = "a" * 141 }
    it { should_not be_valid }
  end
end
