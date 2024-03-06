require "pathname"

require_relative "sh_cli_connector_config"

module Foobara
  module Generators
    module ShCliConnectorGenerator
      class GenerateShCliConnector < Foobara::Generators::Generate
        class MissingManifestError < RuntimeError; end

        possible_error MissingManifestError

        inputs ShCliConnectorConfig

        def execute
          add_initial_elements_to_generate

          each_element_to_generate do
            generate_element
          end

          paths_to_source_code
        end

        attr_accessor :manifest_data

        def base_generator
          Generators::ShCliConnectorGenerator
        end

        # TODO: delegate this to base_generator
        def templates_dir
          # TODO: implement this?
          # :nocov:
          "#{__dir__}/../templates"
          # :nocov:
        end

        def add_initial_elements_to_generate
          elements_to_generate << sh_cli_connector_config
        end

        def sh_cli_connector_config
          @sh_cli_connector_config ||= ShCliConnectorConfig.new(inputs)
        end
      end
    end
  end
end
