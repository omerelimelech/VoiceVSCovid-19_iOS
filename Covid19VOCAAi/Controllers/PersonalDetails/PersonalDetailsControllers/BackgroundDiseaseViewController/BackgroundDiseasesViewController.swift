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
    
    var dataSource = ["לא אובחנתי עם אף מחלה","סוכרת","מחלה אוטואמונית","אסטמה","מחלה ריאתית כרונית","מחלת כליות כרונית","יתר לחץ דם","יש או היה לי בעבר סרטן"]
    
    var selectedItems = [IndexPath]()
   
    weak var delegate: PersonalDetailsDelegate?
    
    @IBOutlet weak var continueButton: VoiceUpContinueButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.transform = CGAffineTransform(scaleX: -1, y: 1) // if isRTL
        
        collectionView.allowsMultipleSelection = true
        collectionView.register(UINib(nibName: TextCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: TextCollectionViewCell.reuseId)
    }
    
    @IBAction func continueTapped(_ sender: GradientButton) {
        var values = [String]()
        let selectedIndexPaths = collectionView.indexPathsForSelectedItems?.map({$0.item})
        guard let items = selectedIndexPaths else {return}
        if !items.contains(0){
            values = items.map({dataSource[$0]})
        }
        print (values)
        self.delegate?.personalDetailsViewController(self, didFinishPickingDiseases: values)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }


}



extension BackgroundDiseasesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TextCollectionViewCell.reuseId, for: indexPath) as? TextCollectionViewCell else {return UICollectionViewCell()}
        
        cell.labelText.text = dataSource[indexPath.item]
 
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let spacing: CGFloat = 27
        let cellWidth = (width - spacing - 42) / 2
        let cellHeight = cellWidth * 0.413
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView.indexPathsForSelectedItems?.count == 0 {
            continueButton.setDisabled()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.continueButton.setEnabled()
        if indexPath.item == 0 {
            self.collectionView.indexPathsForSelectedItems?.forEach({if $0.item != 0 { collectionView.deselectItem(at: $0, animated: false)}})
        }else{
            if collectionView.indexPathsForSelectedItems?.contains(IndexPath(item: 0, section: 0)) ?? false{
                collectionView.deselectItem(at: IndexPath(item: 0, section: 0), animated: false)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 27
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



