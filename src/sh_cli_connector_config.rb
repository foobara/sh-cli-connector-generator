require "English"

module Foobara
  module Generators
    module ShCliConnectorGenerator
      class ShCliConnectorConfig < Foobara::Model
        attributes do
          name :string, :required
        end
      end
    end
  end
end
