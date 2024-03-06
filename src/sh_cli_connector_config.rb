require "English"

module Foobara
  module Generators
    module ShCliConnectorGenerator
      class ShCliConnectorConfig < Foobara::Model
        attributes do
          sh_cli_connector_name :string, :required
          description :string, :allow_nil
        end

        attr_accessor :module_path

        def initialize(attributes = nil, options = {})
          sh_cli_connector_name = attributes[:sh_cli_connector_name]
          description = attributes[:description]

          module_path = sh_cli_connector_name.split("::")

          super(
            {
              sh_cli_connector_name:,
              description:
            },
            options
          )

          self.module_path = module_path
        end
      end
    end
  end
end
