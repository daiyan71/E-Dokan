json.extract! product, :id, :product_category_id, :available, :name, :image, :price, :description, :created_at, :updated_at
json.url product_url(product, format: :json)
