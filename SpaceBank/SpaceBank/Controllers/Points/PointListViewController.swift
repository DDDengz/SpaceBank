//
//  PointListViewController.swift
//  SpaceBank
//
//  Created by Sam on 10.05.17.
//  Copyright © 2017 Semyon Vyatkin. All rights reserved.
//

import UIKit

class PointListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    fileprivate let viewModel = PointsViewModel()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    // MARK: - Appearance
    private func setupTableView() {
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: PointTableViewCell.id, bundle: Bundle.main),
                           forCellReuseIdentifier: PointTableViewCell.id)
    }
    
    // MARK: - Methods
    private func fetchData() {
        indicatorView.startAnimating()
        viewModel.fetch({ [weak weakSelf = self] in
            guard let strongSelf = weakSelf else { return }
            strongSelf.indicatorView.stopAnimating()
            strongSelf.tableView.reloadData()
        })
        { [weak weakSelf = self] (error) in            
            guard let strongSelf = weakSelf else { return }
            strongSelf.indicatorView.stopAnimating()
        }
    }
}

// MARK: - TableView DataSource
extension PointListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.points.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PointTableViewCell.id, for: indexPath) as! PointTableViewCell
        let point = viewModel.points[indexPath.row]
        
        cell.title = point.name
        cell.address = point.address
        cell.schedule = point.schedule
        
        return cell
    }
}
