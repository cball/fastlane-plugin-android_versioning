require 'spec_helper'

describe Fastlane::Actions::IncrementVersionNameAction do
  describe "Increment version name" do
    before do
      copy_build_fixture
    end

    def execute_lane_test
      Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\"
        )
      end").runner.execute(:test)
    end

    it "should return incremented version name from build.gradle" do
      expect(execute_lane_test).to eq("1.0.1")
    end

    it "should return incremented version name with minor from build.gradle" do
      result = Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\",
          bump_type: \"minor\"
        )
      end").runner.execute(:test)
      expect(result).to eq("1.1.0")
    end

    it "should return incremented version name with major from build.gradle" do
      result = Fastlane::FastFile.new.parse("lane :test do
        increment_version_name(
          app_project_dir: \"../**/app\",
          bump_type: \"major\"
        )
      end").runner.execute(:test)
      expect(result).to eq("2.0.0")
    end

    it "should set VERSION_NAME shared value" do
      result = execute_lane_test
      expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::VERSION_NAME]).to eq("1.0.1")
    end

    after do
      remove_fixture
    end
  end
end
