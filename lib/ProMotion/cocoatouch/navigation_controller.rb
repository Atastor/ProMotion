module ProMotion
  class NavigationController < UINavigationController

    def popViewControllerAnimated(animated)
      if self.viewControllers[-2].respond_to? :on_back
        self.viewControllers[-2].send(:on_back)
      end
      super animated
    end

    def shouldAutorotate
      visibleViewController.shouldAutorotate
    end

    def supportedInterfaceOrientations
      visibleViewController.supportedInterfaceOrientations
    end

    def preferredInterfaceOrientationForPresentation
      visibleViewController.preferredInterfaceOrientationForPresentation
    end

  end
end
