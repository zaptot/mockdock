class Endpoint < ApplicationRecord
  BASE_HOST = 'https://example.com/'
  METHODS = %w[post get put delete patch options].freeze

  has_many :requests, dependent: :delete_all

  enum http_method: METHODS.to_h { |m| [m, m] }, _scopes: false

  before_validation :update_path

  validates_inclusion_of :response_code, in: 100..599

  class << self
    def fetch_endpoint!(path, http_method)
      find_by!(path: processed_path(path), http_method: http_method)
    end

    def processed_path(path)
      URI.parse(File.join(BASE_HOST, path)).path
    end
  end

  def beauty_name
    "#{http_method.upcase}: #{path}"
  end

  private

  def update_path
    self.path = self.class.processed_path(path)
  end
end
