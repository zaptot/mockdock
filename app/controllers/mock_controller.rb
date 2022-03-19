class MockController < ApplicationController
  skip_before_action :verify_authenticity_token

  Endpoint::METHODS.each do |method_name|
    define_method method_name do
      mock_path = params['dymamic_mock_path']
      endpoint = Endpoint.fetch_endpoint!(mock_path, method_name)
      save_request!(endpoint, method_name)

      render json: endpoint.response_data, status: endpoint.response_code
    end
  end

  private

  def save_request!(endpoint, method_name)
    Request.create!(
      params: params.except(*%w[dymamic_mock_path controller action]),
      http_method: method_name,
      endpoint: endpoint,
      headers: request.headers
                      .to_h
                      .reject { |k, _| %w[rack puma action_dispatch action_controller].any? { |h| k.include?(h) } }
    )
  end
end
