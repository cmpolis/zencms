require 'spec_helper'

describe Admin::ImagesController do
  before(:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user
    
    3.times do
      @image = FactoryGirl.create(:image)
    end
  end

  describe "GET #index" do
    it "populates an array of images" do
      get :index
      assigns(:images).should have(3).items
    end
  end

  describe "GET #show" do
    it "shows a specic image" do
      get :show, id: @image

      response.should render_template :show
      assigns(:image).should eq(@image)
    end
  end

  describe "POST #create" do
    it "creates a new image object" do
      expect {
        file = File.join(%w(spec support placekitten.jpeg).unshift(Rails.root))
        post :create, image: { name: 'newtestimg',
                               file: Rack::Test::UploadedFile.new(file, "image/jpeg") }
      }.to change(Image, :count).by(1)
      Image.where(name: 'newtestimg').first.file.should_not be_nil
    end
  end

  # describe "PUT #update" do
  #   it "can update attributes" do
  #     put :update, id: @style, style: { name: 'new_name',
  #                                        content: 'body { color: blue; }' }
  #     @style.reload.name.should eql 'new_name'
  #     @style.content.should include 'color: blue;'
  #   end
  #   it "can use reference url" do
  #     put :update, id: @style, style: { name: 'new_name',
  #                                       content: nil, 
  #                                       reference_url: 'http://google.com/test.js' }
  #     @style.reload.reference_url.should include 'test.js'
  #  end
  # end

end
