class CampaignsController < ApplicationController

  def new
    @campaign = Campaign.new
  end

  def create
    campaign_params = params.require(:campaign).permit(:title, :body, :goal, :end_date)
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to campaign_path(@campaign), notice: "Campaign created!"
    else
      flash[:alert] = "Problem!"
      render :new
    end
  end

  def show
    @campaign = Campaign.find params[:id]
  end
end
