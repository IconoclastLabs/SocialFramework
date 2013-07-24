describe "Application 'SocialFramework'" do
  before do
    @app = UIApplication.sharedApplication
  end

  it "has at least one window" do
    @app.windows.size.should >= 1
  end
end
