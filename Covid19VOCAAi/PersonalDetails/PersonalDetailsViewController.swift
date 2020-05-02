//
//  PersonalDetailsViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 01/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class PersonalDetailsViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var controllers: [UIViewController] = {
        let sb = UIStoryboard.init(name: "PersonalDetails", bundle: nil)
        guard let pd1 = sb.instantiateViewController(withIdentifier: "pd1") as? PersonalDetails1ViewController else {return []}
        pd1.delegate = self
        let pd2 = sb.instantiateViewController(withIdentifier: "pd2")
        let pd3 = sb.instantiateViewController(withIdentifier: "pd3")
        let pd4 = sb.instantiateViewController(withIdentifier: "pd4")
        return [pd1,pd2,pd3,pd4]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setViewControllers([controllers.first!], direction: .forward, animated: true, completion: nil)
        dataSource = self
        
        
        
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = self.controllers.firstIndex(of: viewController) else {return nil}
        let prevIndex = index - 1
        guard prevIndex >= 0 else {return nil}
        guard controllers.count > prevIndex else {return nil}
        
        return controllers[prevIndex]
    }


    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = self.controllers.firstIndex(of: viewController) else {return nil}
        let nextIdnex = index + 1
        guard controllers.count != nextIdnex else {return nil}
        guard controllers.count > nextIdnex else {return nil}
        return controllers[nextIdnex]
    }

}


extension PersonalDetailsViewController : PersonalDetailsDelegate {
    func personalDetailsViewController(_ controller: UIViewController, didTapContiueWith values: [String : Any]) {
        self.goToNextPage()
    }
    
    
}

extension UIPageViewController {
    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        if let currentViewController = viewControllers?[0] {
            if let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentViewController) {
                setViewControllers([nextPage], direction: .reverse, animated: animated, completion: completion)
            }
        }
    }
}
