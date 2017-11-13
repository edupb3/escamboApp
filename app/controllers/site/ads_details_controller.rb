class Site::AdsDetailsController < SiteController
  def show
    @ad = Ad.find(params[:id])
  end
end
