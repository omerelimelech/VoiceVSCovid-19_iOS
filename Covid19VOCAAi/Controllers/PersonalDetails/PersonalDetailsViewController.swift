//
//  PersonalDetailsViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 01/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

enum PersonalDetailsKey: String{
    case phoneNumber = "phoneNumber"
    case age = "age"
    case sex = "sex"
    case country = "country"
    case weight = "weight"
    case height = "height"
    case smokingStatus = "smokingStatus"
    case backgroundDiseases = "backgroundDiseases"
    
    func key() -> String{
        return self.rawValue
    }
}


enum Sex: String {
    case male = "MALE"
    case female = "FEMALE"
}

enum SmokingStatus: String {
    case current = "CURRENT"
    case never = "NEVER"
    case stopped = "STOPPED"
}
class UserInfo {
    
    var phoneNumber: String?
    var age: Int?
    var sex: Sex?
    var country: String?
    var weight: String?
    var height: String?
    var smokingStatus: SmokingStatus?
    var backgroundDiseases: [String]?
    
}

class PersonalDetailsViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    static func initialization() -> PersonalDetailsViewController {
        return UIStoryboard(name: "PersonalDetails", bundle: nil).instantiateViewController(withIdentifier: "peronalDetailsPageController") as! PersonalDetailsViewController
    }
    
    var userInfo = UserInfo()
    
    lazy var controllers: [UIViewController] = {
        let sb = UIStoryboard.init(name: "PersonalDetails", bundle: nil)
        let pd1 = sb.instantiateViewController(withIdentifier: "pd1") as! PersonalDetails1ViewController
        pd1.delegate = self
        let pd2 = sb.instantiateViewController(withIdentifier: "pd2") as! PersonalDetails2ViewController
        pd2.delegate = self
        let pd3 = sb.instantiateViewController(withIdentifier: "pd3") as! PersonalDetails3ViewController
        pd3.delegate = self
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
    func personalDetailsViewController(_ controller: UIViewController, didTapContiueWith values: [String : Any?]) {
      
        if let _ = controller as? PersonalDetails1ViewController {
            self.userInfo.country = values[PersonalDetailsKey.country.rawValue] as? String
             self.userInfo.phoneNumber = values[PersonalDetailsKey.phoneNumber.rawValue] as? String
        }
        
        if let _ = controller as? PersonalDetails2ViewController {
            self.userInfo.age = Int(values[PersonalDetailsKey.age.rawValue] as! String)
            self.userInfo.sex = values[PersonalDetailsKey.sex.rawValue] as? Sex
            self.userInfo.weight = values[PersonalDetailsKey.weight.rawValue] as? String
            self.userInfo.height = values[PersonalDetailsKey.height.rawValue] as? String
        }
        
        if let _ = controller as? PersonalDetails3ViewController {
            self.userInfo.smokingStatus = values[PersonalDetailsKey.smokingStatus.rawValue] as? SmokingStatus
        }
        
        self.userInfo.backgroundDiseases = values[PersonalDetailsKey.backgroundDiseases.rawValue] as? [String]
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
