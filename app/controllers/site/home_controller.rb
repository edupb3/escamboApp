class Site::HomeController < SiteController
  
  def index
    @categories = Category.order_by_description
    @ads = Ad.descending_order(3)
  end
end
