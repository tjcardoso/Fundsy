require 'rails_helper'

RSpec.describe CampaignsController, type: :controller do

  describe "#new" do
    before { get :new }

    it "renders the new template" do
      # response is an object that RSpec provides us that will contain the
      # controller response data which will help us test things such as rendering
      # templates or redirecting to a specific page.
      # render_template is a matcher from rspec-rails to test rendering a specific
      # Rails template
      expect(response).to render_template(:new)
    end

    it "assigns a campaign object" do
      expect(assigns(:campaign)).to be_a_new(Campaign)
    end
  end

  describe "#create" do
    describe "with valid attributes" do
      # methods defined with in `describe` are only available to examples
      # defined within the same describe (also applies to `context`)
      def valid_request
        post :create, campaign: {title: "abc", goal: 100, body: "123"}
      end

      it "saves a record to the database" do
        count_before = Campaign.count
        valid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before + 1)
      end

      it "redirects to the campaign's show page" do
        valid_request
        expect(response).to redirect_to(campaign_path(Campaign.last))
      end

      it "sets a flash message" do
        valid_request
        expect(flash[:notice]).to be
      end
    end

    describe "with invalid attributes" do
      def invalid_request
        post :create, campaign: {goal: 12}
      end

      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end

      it "sets an alert message" do
        invalid_request
        expect(flash[:alert]).to be
      end

      it "doesn't save a record to the database" do
        count_before = Campaign.count
        invalid_request
        count_after = Campaign.count
        expect(count_after).to eq(count_before)
      end
    end
  end

  describe "#show" do
    before do
      @c = Campaign.create(title: "valid title", goal: 123)
      get :show, id: @c.id
    end

    it "renders the show template" do
      expect(response).to render_template(:show)
    end

    it "sets a campaign instance variable" do
      expect(assigns(:campaign)).to eq(@c)
    end
  end

end
