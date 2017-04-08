class StaticPagesController < ApplicationController
  def about;end
  def top
    @jurisdictions = Jurisdiction.all
    @jurisdiction_selected = params[:jurisdiction] || 'chiba'
  end
end
