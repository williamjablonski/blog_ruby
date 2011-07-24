require 'spec_helper'

describe CategoriesController do

  render_views

  before(:each) do
    controller.stubs(:user_signed_in?).returns(false)
  end

  describe "visit a category" do
    it "should respond to html" do
      category = Factory(:category, name: "my_category")
      Factory(:post, categories: [category])
      get :show, id: "my_category"
      response.should be_success
      response.should render_template(:show)
    end
  end

end
