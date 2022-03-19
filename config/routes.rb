Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  Endpoint::METHODS.each do |method_name|
    send method_name, '/*dymamic_mock_path', to: ['mock', method_name].join('#')
  end
end
