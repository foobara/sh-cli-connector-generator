module Foobara
  module Generators
    module ShCliConnectorGenerator
      module Generators
        # Kind of tricky... for the first time we will be loading an existing file in the working directory
        # and modifying it.
        class GemfileGenerator < ShCliConnectorGenerator
          def template_path
            "Gemfile"
          end

          def target_path
            "Gemfile"
          end

          def generate(_elements_to_generate)
            contents = File.read(template_path)

            match = contents.match(/^gem /)

            if match
              new_entry = 'gem "foobara-sh-cli-connector", github: "foobara/sh-cli-connector"'
              "#{match.pre_match}\n#{new_entry}\n#{match}#{match.post_match}"
            else
              # TODO: maybe print a warning and return the original Gemfile
              # :nocov:
              raise "Not sure how to inject sh_cli_connector into the Gemfile"
              # :nocov:
            end
          end
        end
      end
    end
  end
end
