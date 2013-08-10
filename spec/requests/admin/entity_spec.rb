require 'spec_helper'

describe 'Entity' do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @props = [FactoryGirl.build(:property, req: true, name: 'first'),
              FactoryGirl.build(:property)]
    @type = FactoryGirl.create(:type, properties: @props)

    login_as(@user, scope: :user)
  end

  describe "View Entity List" do
    it "Responds to the right url and shows name" do
      visit "/admin/entity/#{@type}"

      page.status_code.should be 200
      page.should have_content @type.name.titleize
    end

    it "Shows a list of entities for your type and their attributes" do
      @entity = Entity.create(type: @type,
                              values: { @props[0].name => 'val1',
                                        @props[1].name => 'val2' })
      visit "/admin/entity/#{@type}"

      page.should have_content @props[0].name
      page.should have_content @props[1].name

      page.should have_content 'val1'
      page.should have_content 'val2'
    end

    context "Testing property types" do
      before(:each) do
        @props = [FactoryGirl.build(:property, name: 'enum',
                                               kind: :enum,
                                               possible: %w(a b c)),
                  FactoryGirl.build(:property, name: 'string',
                                               kind: :string),
                  FactoryGirl.build(:property, name: 'array',
                                               kind: :array),
                  FactoryGirl.build(:property, name: 'text',
                                               kind: :text)]
        @type = FactoryGirl.create(:type, properties: @props)
        visit "/admin/entity/#{@type}"
      end

      it "Shows a text input for string kind" do
        page.should have_field 'String'
      end

      it "Shows a text area for text kind" do
        page.should have_field 'Text', type: 'textarea'
      end

      it "Shows a select with correct enum values" do
        page.should have_select 'Enum', options: %w(a b c)
      end

    end

  end

  describe "Create Entity" do
    before { visit "/admin/entity/#{@type}" }

    it "Creates an entity" do
      expect {
        fill_in @props[0].name.capitalize, with: 'Sample Value for 1'
        fill_in @props[1].name.capitalize, with: 'Another'
        click_on 'Create'
      }.to change(Entity, :count).by(1)
      page.should have_content 'Another'
    end

    it "Requires required attributes" do
      expect {
        fill_in @props[0].name.capitalize, with: '' # req field
        fill_in @props[1].name.capitalize, with: 'Another'
        click_on 'Create'
      }.to_not change(Entity, :count).by(1)
      page.should_not have_content 'Another'
    end
  end

  describe "Destroy Entity" do
    it "Destroys an entity" do 
      @entity = Entity.create(type: @type,
                              values: { @props[0].name => 'val1',
                                        @props[1].name => 'val2' })
      visit "/admin/entity/#{@type}"

      expect {
        first(:link, 'Remove').click
      }.to change(Entity, :count).by(-1)
    end
  end

  describe "Edit specific entity" do
    before(:each) do
      @entity = Entity.create(type: @type,
                              values: { @props[0].name => 'val1',
                                        @props[1].name => 'val2',
                              default_path: 'pathtoenlightenment' })
      visit "/admin/entity/#{@type}/#{@entity.id}"
    end

    it "Shows entity values" do
      find_field('First').value.should eq 'val1'
    end
    
    it "Allows changing entity values" do
      fill_in 'First', with: 'newfirst'
      click_on 'Update'

      @entity.reload.values['first'].should eq 'newfirst'
    end

    it "Allows changing the entity path" do
      fill_in 'Default Path', with: 'newpath'
      click_on 'Update'

      @entity.reload.default_path.should eq 'newpath'
    end
  end

end
