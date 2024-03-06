module Foobara
  module Generators
    module ShCliConnectorGenerator
      module Generators
        class BinExecutableGenerator < ShCliConnectorGenerator
          def template_path
            ["bin", "cli.erb"]
          end

          def target_path
            ["bin", name]
          end
        end
      end
    end
  end
end
