require "English"

module Foobara
  module Generators
    module ShCliConnectorGenerator
      class ShCliConnectorConfig < Foobara::Model
        attributes do
          name :string, :required
          rbenv :boolean, default: false, description: "This will rbenv rehash if set"
        end
      end
    end
  end
end
