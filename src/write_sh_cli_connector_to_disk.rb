require_relative "generate_sh_cli_connector"
require "foobara/files_generator/bundler_actions"

module Foobara
  module Generators
    module ShCliConnectorGenerator
      class WriteShCliConnectorToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        include Foobara::FilesGenerator::BundlerActions

        class << self
          def generator_key
            "sh-cli-connector"
          end
        end

        depends_on GenerateShCliConnector

        inputs do
          sh_cli_connector_config ShCliConnectorConfig, :required
          # TODO: should be able to delete this and inherit it
          output_directory :string
        end

        def execute
          generate_file_contents
          write_all_files_to_disk
          run_post_generation_tasks

          stats
        end

        def output_directory
          inputs[:output_directory] || default_output_directory
        end

        def default_output_directory
          "."
        end

        def generate_file_contents
          # TODO: just pass this in as the inputs instead of the sh_cli_connector??
          self.paths_to_source_code = run_subcommand!(GenerateShCliConnector, sh_cli_connector_config.attributes)
        end

        def run_post_generation_tasks
          Dir.chdir output_directory do
            bundle_install
            rubocop_autocorrect

            if rbenv?
              rbenv_rehash
            end
          end
        end

        def rbenv?
          sh_cli_connector_config.rbenv
        end

        def rubocop_autocorrect
          puts "linting..."

          cmd = "bundle exec rubocop --no-server -A"

          if Bundler.respond_to?(:with_unbundled_env)
            Bundler.with_unbundled_env do
              run_cmd_and_return_output(cmd)
            end
          else
            # :nocov:
            run_cmd_and_return_output(cmd)
            # :nocov:
          end
        rescue CouldNotExecuteError => e
          # :nocov:
          warn e.message
          # :nocov:
        end

        def rbenv_rehash
          cmd = "rbenv rehash"
          run_cmd_and_return_output(cmd)
        rescue CouldNotExecuteError => e
          # :nocov:
          warn e.message
          # :nocov:
        end
      end
    end
  end
end
