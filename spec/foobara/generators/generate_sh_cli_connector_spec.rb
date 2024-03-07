RSpec.describe Foobara::Generators::ShCliConnectorGenerator::GenerateShCliConnector do
  let(:name) { "some-cli" }

  let(:inputs) do
    {
      name:
    }
  end
  let(:sh_cli_connector) { described_class.new(inputs) }
  let(:outcome) { sh_cli_connector.run }
  let(:result) { outcome.result }

  it "generates a sh_cli_connector" do
    expect(outcome).to be_success

    expect(result.keys).to include("bin/some-cli")
  end
end
