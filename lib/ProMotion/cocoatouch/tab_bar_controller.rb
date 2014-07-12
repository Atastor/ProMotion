module ProMotion
  class TabBarController < UITabBarController

    def self.new(*screens)
      tab_bar_controller = alloc.init

      screens = screens.flatten.map { |s| s.respond_to?(:new) ? s.new : s } # Initialize any classes

      tag_index = 0
      view_controllers = screens.map do |s|
        s.tabBarItem.tag = tag_index
        s.tab_bar = WeakRef.new(tab_bar_controller) if s.respond_to?("tab_bar=")
        tag_index += 1
        s.navigationController || s
      end

      tab_bar_controller.viewControllers = view_controllers
      tab_bar_controller
    end

    def open_tab(tab)
      if tab.is_a? String
        selected_tab_vc = find_tab(tab)
      elsif tab.is_a? Numeric
        selected_tab_vc = viewControllers[tab]
      end

      if selected_tab_vc
        self.selectedViewController = selected_tab_vc
      else
        PM.logger.error "Unable to open tab #{tab.to_s} -- not found."
        nil
      end
    end

    def find_tab(tab_title)
      self.viewControllers.find { |vc| vc.tabBarItem.title == tab_title }
    end

  end
end
