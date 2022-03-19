ActiveAdmin.register Endpoint do
  permit_params :path, :http_method, :response_code, :response_data

  filter :http_method, as: :select, collection: Endpoint::METHODS
  filter :path, as: :select, collection: -> { Endpoint.distinct.pluck(:path) }

  form do |f|
    f.inputs do
      if f.object.new_record?
        f.input :path
        f.input :http_method, as: :select, collection: Endpoint::METHODS
      end

      f.input :response_code
      f.input :response_data
    end

    f.actions
  end
end
