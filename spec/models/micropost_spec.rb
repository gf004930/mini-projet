# == Schema Information
#
# Table name: microposts
#
#  id         :integer          not null, primary key
#  content    :string(255)
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string(255)
#  post_type  :string(255)
#

require 'spec_helper'

describe Micropost do

  let(:user) { FactoryGirl.create(:user) }
  before { @micropost = user.microposts.build(title: "title", post_type: "journal", content: "Lorem ipsum") }

  subject { @micropost }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
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
    before { @micropost.content = "a" * 141 }
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
end
