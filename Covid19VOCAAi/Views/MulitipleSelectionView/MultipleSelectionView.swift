//
//  MultipleSelectionView.swift
//  Covid19VOCAAi
//
//  Created by Omer Elimelech on 05/04/2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import Foundation
import UIKit

protocol ConfigureView{
    func configure(with title: String, dataSource: [LocalizedEnum]?, isPrimary: Bool)
}
class MultipleSelectionView: BaseView , ConfigureView{

    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
        
    var dataSource = [LocalizedEnum]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialConfig()
        
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialConfig()
    }
    
    override func initialConfig() {
        super.initialConfig()
        isHidden = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: SelectionTableViewCell.reuseId, bundle: nil), forCellReuseIdentifier: SelectionTableViewCell.reuseId)
    }
    
    
    func configure(with title: String, dataSource: [LocalizedEnum]?, isPrimary: Bool){
        guard let dataSource = dataSource else {return}
        self.dataSource = dataSource
        self.questionLabel.text = String(format: "%@ %@", title, isPrimary ? "*" : "")
        tableView.performBatchUpdates({
            self.tableViewHeight.constant = CGFloat(self.dataSource.count * 50)
            layoutIfNeeded()
        }, completion: nil)
          
    }
    
    func getData() -> [String] {
        guard let visibleCells = tableView.visibleCells as? [SelectionTableViewCell] else {return []}
        return visibleCells.filter({$0.isSelected}).map({$0.localizedTitle?.englishValue ?? ""})
    }
    
    
}

extension MultipleSelectionView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectionTableViewCell.reuseId, for: indexPath) as? SelectionTableViewCell else {return UITableViewCell()}
        
        cell.localizedTitle = dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
