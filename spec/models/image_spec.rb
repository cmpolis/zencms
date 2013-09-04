require 'spec_helper'

describe Image do
  before(:each) do
    @image = FactoryGirl.create(:image)
  end

  it 'should have a valid factory' do
    @image.should be_valid
  end

  it 'must have a unique name' do
    FactoryGirl.build(:image, name: nil).should_not be_valid
    FactoryGirl.build(:image, name: @image.name).should_not be_valid
  end

  it 'can have a linked file' do
    newImage = FactoryGirl.create(:image, file: nil)
    file = File.join(%w(spec support placekitten.jpeg).unshift(Rails.root))

    newImage.update_attributes(file: Rack::Test::UploadedFile.new(file))
    newImage.file.should_not be_nil
  end

end
