RSpec.describe Foobara::Generators::ShCliConnectorGenerator::GenerateShCliConnector do
  let(:sh_cli_connector_name) { "SomePrefix::SomeOrg" }

  let(:inputs) do
    {
      sh_cli_connector_name:,
      description: "whatever"
    }
  end
  let(:sh_cli_connector) { described_class.new(inputs) }
  let(:outcome) { sh_cli_connector.run }
  let(:result) { outcome.result }

  it "generates a sh_cli_connector" do
    expect(outcome).to be_success

    sh_cli_connector_file = result["src/some_prefix/some_org.rb"]
    expect(sh_cli_connector_file).to include("module SomeOrg")
    expect(sh_cli_connector_file).to include("module SomePrefix")
  end
end
