describe "RootController" do
  tests RootController

  before do
    @sheet = controller.instance_variable_get("@action_sheet")
    @all_buttons = []
    for i in 1..@sheet.numberOfButtons
      @all_buttons << @sheet.buttonTitleAtIndex(i -1)
    end
  end

  it "has manditory amount of buttons" do
    @all_buttons.size.should.be >= 2
  end

  it "has a cancel button" do
    @sheet.cancelButtonIndex.should.not.equal nil
  end  

  it "has Twitter if available" do
    @all_buttons.include?("Twitter").should.equal SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
  end

  it "has Facebook if available" do
    @all_buttons.include?("Facebook").should.equal SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
  end
end