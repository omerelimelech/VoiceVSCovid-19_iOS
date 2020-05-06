//
//  SympthomsViewController.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 04/05/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

struct QuestionElement: Codable {
    let id: Int
    let name, displayName, qtype: String
    let order: Int
    let active: Bool
    let extraData: String
    let questionRequired: Bool
    let addedOn: String
    let jsonExtraData: [JSONExtraDatum]?

    enum CodingKeys: String, CodingKey {
        case id, name, displayName, qtype, order, active, extraData
        case questionRequired = "required"
        case addedOn, jsonExtraData
    }
}

// MARK: - JSONExtraDatum
struct JSONExtraDatum: Codable {
    let optionName, optionValue: String
    let optionImage: String
}

typealias Question = [QuestionElement]


class SympthomsViewController: UIViewController {

    var element: QuestionElement?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: SympthomsPresenter?
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: SympthomsCollectionViewCell.reuseId, bundle: nil), forCellWithReuseIdentifier: SympthomsCollectionViewCell.reuseId)
        self.presenter = SympthomsPresenter(delegate: self)
        self.presenter?.getQuestions()
    }
    


}


extension SympthomsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SympthomsCollectionViewCell.reuseId, for: indexPath) as? SympthomsCollectionViewCell else {return UICollectionViewCell()}
        
        cell.configure(withElement: element?.jsonExtraData?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return element?.jsonExtraData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 20
        let cvWidth = collectionView.frame.width
        let numOfItemsInRow: CGFloat = 3
        let width = (cvWidth - (spacing * (numOfItemsInRow - 1))) / numOfItemsInRow
        return CGSize(width: width, height: width)
    }
}
extension SympthomsViewController: SympthomsDelegate {
    func didFetchData(_ data: QuestionElement?) {
        self.element = data
        collectionView.reloadData()
    }
}

protocol SympthomsDelegate{
    func didFetchData(_ data: QuestionElement?)
}

class SympthomsPresenter: BasePresenter {
    
    var delegate: SympthomsDelegate?
    
    init(delegate: SympthomsDelegate?){
        self.delegate = delegate
    }
    
    func getQuestions(){
        APIManager.shared.getQuestions(params: nil) { (result) in
            self.handleResult(result: result, type: Question.self) { (questions) in
                if questions?.count ?? 0 > 0{
                    self.delegate?.didFetchData(questions?.first)
                }
            }
        }
    }
}
