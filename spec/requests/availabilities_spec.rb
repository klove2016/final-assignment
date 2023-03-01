require 'rails_helper'

RSpec.describe "Availabilities", type: :request do
  describe "get availabilities_path" do
        it "renders index view" do
            FactoryBot.create_list(:availability, 5)
            get availabilities_path
            expect(response).to render_template(:index)
        end
  end
  describe "get availabilities_path" do
    it "renders the :show template" do
      availability = FactoryBot.create(:availability)
      user = FactoryBot.create(:user)
      availabilities_attributes = FactoryBot.attributes_for(:availability, user_id: user.id)
      get availabilities_path(id: availability.user.id)
      expect(response).to render_template(:show)
    end
  end
  describe "get new_availabilities_path" do
    it "renders the :new template"  do
      availability = FactoryBot.create(:availability)
      user = FactoryBot.create(:user)
      availabilities_attributes = FactoryBot.attributes_for(:availability, user_id: user.id)
      get new_availabilities_path(id: availability.user.id)
      expect(response).to render_template(:new)
    end
  end
  describe "get edit_availabilities_path" do
    it "renders the :edit template"  do
      availability = FactoryBot.create(:availability)
      user = FactoryBot.create(:user)
      availabilities_attributes = FactoryBot.attributes_for(:availability, user_id: user.id)
      get edit_availabilities_path(id: availability.user.id)
      expect(response).to render_template(:edit)
    end
  end
  describe "post availabilities_path with valid data" do
    it "saves a new entry and redirects to the show path for the entry" do
      user = FactoryBot.create(:user)
      availabilities_attributes = FactoryBot.attributes_for(:availability, user_id: user.id)
      expect { post availabilities_path, params: {availability: availabilities_attributes}
    }.to change(Availability, :count)
      expect(response).to redirect_to availabilities_path(id: Availability.last.user_id)
    end
  end
  describe "post availabilities_path with invalid data" do
    it "does not save a new entry or redirect" do
      user = FactoryBot.create(:user)
      availabilities_attributes = FactoryBot.attributes_for(:availability, user_id: user.id)
      availabilities_attributes.delete(:user_id)
      expect { post availabilities_path, params: {availability: availabilities_attributes}
     }.to_not change(Availability, :count)
      expect(response).to render_template(:new)
    end
  end
  describe "put availabilities_path with valid data" do
    it "updates an entry and redirects to the show path for the user" do
      availability = FactoryBot.create(:availability)
      put "/availabilities/#{availability.id}", params: {availability: {product_count: 50}}
      availability.reload
      expect(availability.product_count).to eq(50)
      expect(response).to redirect_to("/availabilities/#{availability.id}")
    end
  end
  describe "put availabilities_path with invalid data" do
    it "does not update the user record or redirect" do
      availability = FactoryBot.create(:availability)
      put "/availabilities/#{availability.id}", params: {availability: {user_id: 5001}}
      availability.reload
      expect(availability.user_id).not_to eq(5001)
      expect(response).to render_template(:edit)
    end
  end
  describe "delete an availability" do
    it "deletes an availability" do
      user = FactoryBot.create(:user)
      availability = FactoryBot.create(:availability)
      expect(Availability.exists?(availability.id)).to be true
      delete availabilities_path(availability)
      expect(Availability.exists?(availability.id)).to be false
      expect(response).to redirect_to (user_path(availability.user_id))
    end
  end
end

