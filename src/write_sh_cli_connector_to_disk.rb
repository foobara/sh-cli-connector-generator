require_relative "generate_sh_cli_connector"

module Foobara
  module Generators
    module ShCliConnectorGenerator
      class WriteShCliConnectorToDisk < Foobara::Generators::WriteGeneratedFilesToDisk
        class << self
          def generator_key
            "sh_cli_connector"
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
          generate_generated_files_json
          delete_old_files_if_needed
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
            rubocop_autocorrect
          end
        end

        def rubocop_autocorrect
          Open3.popen3("bundle exec rubocop -A") do |_stdin, _stdout, stderr, wait_thr|
            exit_status = wait_thr.value
            unless exit_status.success?
              warn "WARNING: could not rubocop -A. #{stderr.read}"
            end
          end
        end
      end
    end
  end
end
