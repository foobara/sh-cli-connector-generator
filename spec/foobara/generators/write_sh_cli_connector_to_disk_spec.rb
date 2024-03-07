RSpec.describe Foobara::Generators::ShCliConnectorGenerator::WriteShCliConnectorToDisk do
  let(:sh_cli_connector) { described_class.new(inputs) }
  let(:outcome) { sh_cli_connector.run }
  let(:result) { outcome.result }
  let(:errors) { outcome.errors }
  let(:inputs) do
    {
      sh_cli_connector_config:,
      output_directory:
    }
  end
  let(:sh_cli_connector_config) do
    {
      name:
    }
  end
  let(:name) { "some-cli" }
  let(:output_directory) { "#{__dir__}/../../../tmp/sh_cli_connector_test_suite_output" }

  around do |example|
    FileUtils.rm_rf output_directory
    FileUtils.mkdir_p output_directory

    project_fixture_dir = "#{__dir__}/../../fixtures/test-project"

    Dir["#{project_fixture_dir}/*", "#{project_fixture_dir}/.*"].each do |f|
      next if f.end_with?(".")

      FileUtils.cp_r f, output_directory
    end

    Dir.chdir output_directory do
      example.run
    end
  end

  describe "#run" do
    it "contains base files" do
      expect(outcome).to be_success

      expect(sh_cli_connector.paths_to_source_code.keys).to include("bin/some-cli")
    end

    it "updates the Gemfile" do
      expect(outcome).to be_success

      expect(
        sh_cli_connector.paths_to_source_code["Gemfile"]
      ).to include('gem "foobara-sh-cli-connector", github: "foobara/foobara-sh-cli-connector"')
    end

    it "updates the .gemspec to add to the list of executables" do
      expect(outcome).to be_success

      expect(
        sh_cli_connector.paths_to_source_code["some-project.gemspec"]
      ).to include('s.executables += ["some-cli"]')
    end
  end

  describe "#output_directory" do
    context "with no output directory" do
      let(:inputs) do
        {
          sh_cli_connector_config:
        }
      end

      it "writes files to the current directory" do
        sh_cli_connector.cast_and_validate_inputs
        expect(sh_cli_connector.output_directory).to eq(".")
      end
    end
  end

  describe ".generator_key" do
    subject { described_class.generator_key }

    it { is_expected.to be_a(String) }
  end
end
