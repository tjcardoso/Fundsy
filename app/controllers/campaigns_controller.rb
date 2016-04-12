class CampaignsController < ApplicationController

  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).permit(:title, :body, :goal, :end_date)
    @campaign = Campaign.create(campaign_params)
    redirect_to campaign_path(@campaign), notice: "Campaign created!"
  end
end
