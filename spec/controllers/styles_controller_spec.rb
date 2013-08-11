require 'spec_helper'

describe StylesController do
  before(:each) do
    @style = FactoryGirl.create(:style, name: 'testcss',
                                        content: 'h1 { color: red }')

  end

  describe "GET #show" do
    it "returns corresponding CSS" do
      get :show, style_name: @style.name

      response.body.should have_content @style.content
    end
  end

end
