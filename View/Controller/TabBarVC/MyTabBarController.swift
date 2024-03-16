//
//  MyTabBarController.swift
//  task_Tailwebs
//
//  Created by Shubham Ramani on 16/03/24.
//
import UIKit

class MyTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.backgroundColor = .lightGray
     
        let firstVC = UIViewController()
        firstVC.view.backgroundColor = .red
        firstVC.tabBarItem = UITabBarItem(title: "First", image: UIImage(systemName: "house"), selectedImage: nil)
        
        let secondVC = UIViewController()
        secondVC.view.backgroundColor = .blue
        secondVC.tabBarItem = UITabBarItem(title: "Second", image: UIImage(systemName: "figure.wave"), selectedImage: nil)
        
        let thirdVC = UIViewController()
        thirdVC.view.backgroundColor = .green
        thirdVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "download"), selectedImage: nil)
        
        let fourthVC = HomeVC()
        fourthVC.view.backgroundColor = UIColor(named: "primaryColor")
        fourthVC.tabBarItem = UITabBarItem(title: "Recorder", image: UIImage(systemName: "mic.circle"), selectedImage: nil)
        
        let fifthVC = UIViewController()
        fifthVC.view.backgroundColor = .purple
        fifthVC.tabBarItem = UITabBarItem(title: "Person", image: UIImage(systemName: "person"), selectedImage: nil)

        // Set round shape for the center tab item
        if let tabBarItems = self.tabBar.items {
            let centerItem = tabBarItems[2] // Assuming the center tab is at index 2
            centerItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -2, right: 0)
            // Adjust the top and bottom insets to move the image up or down
            centerItem.title = nil // Optional: Hide the title if not needed
        }

        // Set up the tab bar controller with the view controllers
        self.viewControllers = [firstVC, secondVC, thirdVC, fourthVC, fifthVC]
        
    }
}
