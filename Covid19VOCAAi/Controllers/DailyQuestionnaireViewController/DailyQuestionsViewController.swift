//
//  DailyQuestionsViewController.swift
//  Covid19VOCAAi
//
//  Created by Yevhenii on 07.05.2020.
//  Copyright © 2020 Omer Elimelech. All rights reserved.
//

import UIKit

class DailyQuestionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableRows = [Row]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        reloadTableData()
    }
    
    private func configure() {
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: StringHelper.stringForClass(QuestionListCell.self), bundle: nil), forCellReuseIdentifier: QuestionListCell.ReuseIdentifier)
        tableView.register(UINib(nibName: StringHelper.stringForClass(ActionButtonCell.self), bundle: nil), forCellReuseIdentifier: ActionButtonCell.ReuseIdentifier)
    }
}
