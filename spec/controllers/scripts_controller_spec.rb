require 'spec_helper'

describe ScriptsController do
  before(:each) do
    @script = FactoryGirl.create(:script, name: 'testjs',
                                          content: 'alert(\'foo\');')

  end

  describe "GET #show" do
    it "returns corresponding JS" do
      get :show, script_name: @script.name 

      response.body.should have_content @script.content
    end
  end

end
