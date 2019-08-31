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
    
    static let id = "ViewController"
    
    let headerRefreshControl = UIRefreshControl()
    let footerProgressView = UIProgressView()
    let limitPerPage = 15
    var repositories = [Repository]()
    var newPageRepos = [Repository]()
    var pageNum = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        
        footerProgressView.tintColor = UIColor.blue
        footerProgressView.trackTintColor = UIColor.gray
        respositoriesTableView.accessibilityIdentifier = "tvRepos"
        respositoriesTableView.dataSource = self
        respositoriesTableView.delegate = self
        respositoriesTableView.tableHeaderView = headerRefreshControl
        respositoriesTableView.tableFooterView = footerProgressView
        
        headerRefreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        
        getRepositories()
    }
    
    func registerCell() {
        let nib = UINib(nibName: RepositoryCell.id, bundle: nil)
        respositoriesTableView.register(nib, forCellReuseIdentifier: RepositoryCell.id)
    }
    
    func getRepositories() {
        DataManager.shared.getRepositories(page: pageNum, limit: limitPerPage, completion: {[unowned self] (response) in
            self.footerProgressView.progress = 100
            self.footerProgressView.isHidden = true
            switch response {
            case .success(let value):
                self.headerRefreshControl.endRefreshing()
                if let repositories = value as? [Repository] {
                    self.handleSuccessResponse(repos: repositories)
                } else if let reposRes = value as? Repositories, let repos = reposRes.repositories {
                    self.handleSuccessResponse(repos: repos)
                }
            case .failure(let apiError, let data):
                self.handleError(apiError: apiError, errotData: data)
            }
        })
    }
    
    func handleSuccessResponse(repos: [Repository]){
        let lastIndex = repos.count == 0 ? -1 : repos.count - 1
        self.repositories.append(contentsOf: repos)
        self.storeReposInApp(repos: self.repositories)
        self.respositoriesTableView.reloadData()
        self.addNewReposToTableView(newRepos: repos, lastIndex: lastIndex)
        self.pageNum += 1
    }
    
    func handleError(apiError: ApiError?, errotData: Any?) {
        if let err = errotData as? ErrorModel{
            self.alert(title: "", message: err.message, completion: {
                self.getReposFormDb()
            })
        } else if let errorArr = errotData as? [ErrorModel], let err = errorArr.first {
            self.alert(title: "", message: err.message, completion: {
               self.getReposFormDb()
            })
        }
    }
    
    func getReposFormDb(){
        DataManager.shared.getDataFormDB(key: .Repos, model: Repositories.self) { (response) in
            switch response {
            case .success(let value):
                self.headerRefreshControl.endRefreshing()
                guard let reposRes = value as? Repositories, let repos = reposRes.repositories  else { return }
                self.handleSuccessResponse(repos: repos)
            case .failure( _, let data):
                guard let err = data as? ErrorModel else { return }
                self.alert(title: "", message: err.message, completion: nil)
            }
        }
    }
    
    func addNewReposToTableView(newRepos: [Repository], lastIndex: Int){
        self.newPageRepos = newRepos
        var indexs = [IndexPath]()
        for i in (lastIndex + 1)..<newRepos.count {
            indexs.append(IndexPath(row: i, section: 0))
        }
        respositoriesTableView.performBatchUpdates({
            self.respositoriesTableView.insertRows(at: indexs, with: .automatic)
        }) { (completed) in
            //Code
        }
    }
    
    func getNewReposPage(){
        self.footerProgressView.isHidden = false
        self.footerProgressView.progress = 0
        self.footerProgressView.setProgress(100, animated: true)
        self.getRepositories()
    }
    
    func storeReposInApp(repos: [Repository]){
        do {
            try StorageManager.shared.saveData(data: Repositories(repositories: repos), for: .Repos)
        } catch let error {
            self.alert(title: "", message: error.localizedDescription, completion: nil)
        }
    }

    @objc func refreshTableView(){
        pageNum = 1
        repositories.removeAll()
        getRepositories()
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard newPageRepos.count == limitPerPage && indexPath.row == repositories.count - 4 else { return }
        getNewReposPage()
    }
}

