//
//  ViewController.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var respositoriesTableView: UITableView!
    
    let headerRefreshControl = UIRefreshControl()
    let footerProgressView = UIProgressView()
    var repositories = [Repository]()
    
    var pageNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
        respositoriesTableView.dataSource = self
        respositoriesTableView.delegate = self
        respositoriesTableView.tableHeaderView = headerRefreshControl
        respositoriesTableView.tableFooterView = footerProgressView
        
        getRepositories()
    }
    
    func registerCell(){
        let nib = UINib(nibName: RepositoryCell.id, bundle: nil)
        respositoriesTableView.register(nib, forCellReuseIdentifier: RepositoryCell.id)
    }
    
    func getRepositories(){
        DataManager.shared.getRepositories(page: pageNum, completion: { (response) in
            self.footerProgressView.isHidden = true
            switch response {
            case .success(let value):
                guard let repositories = value as? [Repository] else { return }
                self.repositories.append(contentsOf: repositories)
                self.respositoriesTableView.reloadData()
                self.pageNum += 1
            case .failure(let apiError, let data):
                self.handleError(apiError: apiError, errotData: data)
            }
        })
    }
    
    func handleError(apiError: ApiError?, errotData: Any?){
        //
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.id, for: indexPath) as? RepositoryCell else { return RepositoryCell() }
        let repo = repositories[index]
        cell.bindOnData(repo)
        return cell
    }
    
}

