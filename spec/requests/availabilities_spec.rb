require 'rails_helper'

RSpec.describe "Availabilities", type: :request do

  let(:user) { FactoryBot.create(:user) } 
  describe "GET /users/:user_id/availabilities" do
    

    it "renders the show view" do
      availability = FactoryBot.create(:availability, user_id: user.id)
      get user_availability_path(user, availability)
      expect(response).to render_template(:show)
    end

    it "renders the new view" do
      get new_user_availability_path(user)
      expect(response).to render_template(:new)
    end

    it "renders the edit view" do
      availability = FactoryBot.create(:availability, user: user)
      get edit_user_availability_path(user, availability)
      expect(response).to render_template(:edit)
    end

    it "redirects to the index view after creating an availability" do
      post user_availabilities_path(user), params: { availability: FactoryBot.attributes_for(:availability) }
      expect(response).to redirect_to user_availability_path(user, assigns(:availability))
    end
    

    it "redirects to the show view after updating an availability" do
      availability = FactoryBot.create(:availability, user: user)
      availability_params = FactoryBot.attributes_for(:availability)
      put user_availability_path(user, availability), params: { availability: availability_params }
      expect(response).to redirect_to(user_availability_path(user))
    end

    it "redirects to the index view after destroying an availability" do
      availability = FactoryBot.create(:availability, user: user)
      expect {
        delete user_availability_path(user, availability)
      }.to change(user.availabilities, :count).by(-1)
      expect(response).to redirect_to(user_availabilities_path(user))
    end
  end
end
 