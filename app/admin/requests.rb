ActiveAdmin.register Request do
  actions :index, :show

  filter :endpoint, as: :select, collection: proc {
    Endpoint.select(:http_method, :path, :id).map do |e|
      [e.beauty_name, e.id]
    end
  }
  filter :created_at

  index do
    column(:endpoint) { |request| auto_link(request.endpoint, request.endpoint.beauty_name) }
    column(:params)
    column(:created_at)
  end
end
