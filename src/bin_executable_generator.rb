module Foobara
  module Generators
    module ShCliConnectorGenerator
      module Generators
        class ShCliConnectorGenerator < Foobara::FilesGenerator
          class << self
            def manifest_to_generator_classes(manifest)
              case manifest
              when ShCliConnectorConfig
                [
                  Generators::ShCliConnectorGenerator
                ]
              else
                # :nocov:
                raise "Not sure how build a generator for a #{manifest}"
                # :nocov:
              end
            end
          end

          def template_path
            ["src", "sh_cli_connector.rb.erb"]
          end

          def target_path
            *path, file = module_path.map { |part| Util.underscore(part) }

            file = "#{file}.rb"

            ["src", *path, file]
          end

          alias sh_cli_connector_config relevant_manifest

          def templates_dir
            "#{__dir__}/../templates"
          end

          # TODO: promote this up to base project
          def ==(other)
            # :nocov:
            self.class == other.class && sh_cli_connector_config == other.sh_cli_connector_config
            # :nocov:
          end

          def hash
            sh_cli_connector_config.hash
          end
        end
      end
    end
  end
end
