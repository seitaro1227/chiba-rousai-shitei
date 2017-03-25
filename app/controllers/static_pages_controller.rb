class StaticPagesController < ApplicationController
  def about;end
  def top
    @jurisdictions = Jurisdiction.all
    @km_options = [%w"500m 1km 2km 3km 5km 10km", %w"0.5 1 2 3 5 10"].transpose
  end
end
