class RootController < UIViewController
  def viewDidLoad
    view.backgroundColor = UIColor.whiteColor

    # Social Framework Action Sheet
    @buttons = ['Camera Roll']
    @social_options = {"Twitter" => SLServiceTypeTwitter, "Facebook" => SLServiceTypeFacebook}
    @social_options.each do |social|
      # dup the element because it will try to pass reference to frozen asset
      @buttons << social[0].dup if SLComposeViewController.isAvailableForServiceType(social[1])
    end

    sheet = UIActionSheet.alloc.initWithTitle(nil,
      delegate:self,
      cancelButtonTitle:nil,
      destructiveButtonTitle:nil,
      otherButtonTitles:nil)
    @buttons.each do |btn|
      sheet.addButtonWithTitle(btn)
    end
    sheet.cancelButtonIndex = sheet.addButtonWithTitle('Cancel')
    sheet.showInView(view)
    @action_sheet = sheet # for testing puposes

    # # THIS IS HOW TO DO IT REAL QUICK WITH SUGARCUBE
    # # https://github.com/rubymotion/sugarcube
    # @buttons = ['Cancel', nil, 'Camera Roll']
    # UIActionSheet.alert(nil, buttons: @buttons,
    #   cancel: proc {p "Cancel - doing nothing is ok"  },
    #   destructive: nil,
    #   success: proc do |pressed|
    #     if @social_options.include? pressed
    #       social_media_post(@social_options[pressed])
    #     elsif pressed == 'Camera Roll'
    #       p "Save to camera roll"
    #     end
    #   end
    # )
  end

  def actionSheet(sheet, didDismissWithButtonIndex:buttonIndex)
    button = @buttons[buttonIndex]
    social_media_post(@social_options[button])
  end

  def social_media_post service
    p "load social media sheet for #{service}"
    social_controller = SLComposeViewController.composeViewControllerForServiceType(service)
    social_controller.setInitialText("@iconoclastlabs ROX!")
    #social_controller.addImage(@some_picture)
    social_controller.addURL(NSURL.URLWithString("http://www.iconoclastlabs.com"))
    social_controller.completionHandler = lambda do |result|
      case result
        when SLComposeViewControllerResultDone
          p "Social post successful"
        when SLComposeViewControllerResultCancelled
          p "Social post cancelled"
      end
    end    
    presentModalViewController(social_controller, animated:true)   
  end
end