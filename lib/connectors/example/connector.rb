#
# Copyright Elasticsearch B.V. and/or licensed to Elasticsearch B.V. under one
# or more contributor license agreements. Licensed under the Elastic License;
# you may not use this file except in compliance with the Elastic License.
#

# frozen_string_literal: true

require 'connectors/base/connector'
require 'utility'

module Connectors
  module Example
    class Connector < Connectors::Base::Connector
      def self.service_type
        'example'
      end

      def self.display_name
        'Example Connector'
      end

      def self.configurable_fields
        {
          'foo' => {
            'label' => 'Foo',
            'value' => nil
          }
        }
      end

      def initialize(configuration: {})
        super
      end

      def do_health_check
        # Do the health check by trying to access 3rd-party system just to verify that everything is set up properly.
        #
        # To emulate unhealthy 3rd-party system situation, uncomment the following line:
        # raise 'something went wrong'
      end

      def yield_documents
        attachments = [
          File.open('./lib/connectors/example/example_attachments/first_attachment.txt'),
          File.open('./lib/connectors/example/example_attachments/second_attachment.txt'),
          File.open('./lib/connectors/example/example_attachments/third_attachment.txt')
        ]

        attachments.each_with_index do |att, index|
          data = { id: (index + 1).to_s, name: "example document #{index + 1}", _attachment: File.read(att) }
          yield data
        end
      end
    end
  end
end
