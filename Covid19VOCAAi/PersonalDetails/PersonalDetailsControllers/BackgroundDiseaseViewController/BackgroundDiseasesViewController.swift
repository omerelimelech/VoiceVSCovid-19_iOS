//
//  BackgroundDiseasesViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 01/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class BackgroundDiseasesViewController: TransformableViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataSource = ["סוכרת","מחלה אוטואמונית","אסטמה","מחלה ריאתית כרונית","מחלת כליות כרונית","יתר לחץ דם","יש או היה לי בעבר סרטן"]
    var selectedItems = [IndexPath]()
    func getWidthds(arr: [String]) -> [String: Int]{
        let font = UIFont(name: "OpenSansHebrew-Regular", size: 16)
        let attribute = [NSAttributedString.Key.font: font]
        
        let newarr = arr.reduce([String: Int]()) { (dict, string) -> [String: Int] in
            var dict = dict
            dict[string] = Int(NSString(string: string).size(withAttributes: attribute as [NSAttributedString.Key : Any]).width)
            return dict
        }
        return newarr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.transform = CGAffineTransform(scaleX: -1, y: 1) // if isRTL
        
        collectionView.allowsMultipleSelection = true
        collectionView.register(UINib(nibName: TextCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: TextCollectionViewCell.reuseId)
        arrangesStrings()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


    private func arrangesStrings(){
        let frame = Int(self.collectionView.frame.width) - 30
           DispatchQueue.global(qos: .background).async {
               let arr = self.getWidthds(arr: self.dataSource)
                var subs = Array(arr.values)
               let subed = subs.getSubstracts(sum: frame)
               
                let sorted = subed.sorted(by: {$0.value.count > $1.value.count})
                let values = Array(sorted.map({$0.value}))
                var arrayToShow = [String]()
                values.forEach { (smallArray) in
                    smallArray.forEach { (width) in
                        arrayToShow.append(contentsOf: arr.keysForValue(value: width))
                    }
                }
               DispatchQueue.main.async {
                   self.dataSource = arrayToShow
                   self.collectionView.reloadData()
               }
           }
    }


}



extension BackgroundDiseasesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCollectionViewCell.reuseId, for: indexPath) as? TextCollectionViewCell else {return UICollectionViewCell()}
        
        cell.labelText.text = dataSource[indexPath.item]
        cell.labelText.font = UIFont(name: "OpenSansHebrew-\(selectedItems.contains(indexPath) ? "Bold" : "Regular")", size: 16)
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItems.append(indexPath)
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        selectedItems.removeAll(where: {$0 == indexPath})
        collectionView.collectionViewLayout.invalidateLayout()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
}

extension Dictionary where Value: Equatable {
    
    func keysForValue(value: Value) -> [Key] {
        return compactMap { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    }
}

class LeftAlignmentCollectionViewLayout : UICollectionViewFlowLayout {

    let cellSpacing:CGFloat = 10

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
           let attributes = super.layoutAttributesForElements(in: rect)

           var leftMargin = sectionInset.left
           var maxY: CGFloat = -1.0
           attributes?.forEach { layoutAttribute in
               if layoutAttribute.frame.origin.y >= maxY {
                   leftMargin = sectionInset.left
               }

               layoutAttribute.frame.origin.x = leftMargin

               leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
               maxY = max(layoutAttribute.frame.maxY , maxY)
           }

           return attributes
       }
}



