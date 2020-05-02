//
//  OnBoardingPageViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 27/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    lazy var controllers: [UIViewController] = {
        let sb = UIStoryboard.init(name: "onboarding", bundle: nil)
        let ob1 = sb.instantiateViewController(withIdentifier: "ob1")
        let ob2 = sb.instantiateViewController(withIdentifier: "ob2")
        let ob3 = sb.instantiateViewController(withIdentifier: "ob3")
        let ob4 = sb.instantiateViewController(withIdentifier: "ob4")
        return [ob1,ob2,ob3,ob4]
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




class TransformableViewController: UIViewController {

    
    func transformSubviewsForView(view: UIView){
        if view.subviews.count > 0 {
            view.subviews.forEach { (view) in
                if view is UIImageView {
                    view.transform = CGAffineTransform(scaleX: -1, y: 1)
                }
                transformSubviewsForView(view: view)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        transformSubviewsForView(view: self.view)
    }
    
}

extension Array where Element == Int {
    
    mutating func getSubstracts(sum: Int) -> [Int: [Int]]{
        var dictToReturn = [Int: [Int]]()
        let sum = 150;
        var round = 0
        let originalSize = self.count
        var numOfTrys = 0
        while count > 0 {
            let g = findSubsets(self, sum)
            if round == originalSize {
                numOfTrys = self.count
            }
            if numOfTrys == 0 && g.count == 1 {
               // found one without matchings, keep trying
            }else if round == originalSize + numOfTrys{
                // we are done!
                dictToReturn[round] = g
                self = Array(Set(self).subtracting(g))
            }else{
              // probably continue searching
            }
            round += 1
        }
        return dictToReturn
    }
    private func sumSubsets(_ set: Array<Int>, _ n: Int, _ target: Int) -> [Int] {
        var n = n
        // Create the new array with size
        // equal to array set[] to create
        // binary array as per n(decimal number)
        var x = [Int](repeating: 0, count: set.count)
        var j = set.count - 1

        // Convert the array into binary array
        while n > 0 {
            x[j] = n % 2
            n = n / 2
            j -= 1
        }

        var sum = 0

        // Calculate the sum of this subset
        for i in 0..<set.count{
            if x[i] == 1 {
                sum = sum + Int(set[i])
            }
        }

        var arrToReturn = [Int]()
        // Check whether sum is equal to target
        // if it is equal, then print the subset
        if Int(Double(target)*0.9)...Int(Double(target)*1.1) ~= sum {
            for i in 0..<set.count {
                if x[i] == 1 {
                    arrToReturn.append(set[i])
                }
            }
        }else{
            return [sum]
        }
        
        return arrToReturn
    }
    

    private func findSubsets(_ arr: Array<Int>, _ K: Int) -> [Int] {
        // Calculate the total no.e of subsets
        let x = pow(2, arr.count)

        var biggestArr = [Int]()
        // Run loop till total no. of subsets
        // and call the function for each subset
        for i in stride(from: 1, to: x, by: +1) {
            let result = sumSubsets(arr, Int(truncating: NSDecimalNumber(decimal: i)) , K)
            if result.count > biggestArr.count { biggestArr = result }
        }
        return biggestArr
    }
}
