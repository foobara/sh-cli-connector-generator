module Foobara
  module Generators
    module ShCliConnectorGenerator
      module Generators
        # Kind of tricky... for the first time we will be loading an existing file in the working directory
        # and modifying it.
        class GemspecGenerator < ShCliConnectorGenerator
          def template_path
            Dir["*.gemspec"].first
          end

          def target_path
            template_path
          end

          def generate(_elements_to_generate)
            contents = File.read(template_path)

            match = contents.match(/^\s*spec\.files\s+=/)

            if match
              new_entry = "spec.executables += [#{name.inspect}]"
              "#{match.pre_match}\n#{new_entry}\n#{match}#{match.post_match}"
            else
              # TODO: maybe print a warning and return the original Gemfile
              # :nocov:
              raise "Not sure how to inject #{name.inspect} into the gemspec's executables"
              # :nocov:
            end
          end
        end
      end
    end
  end
end
