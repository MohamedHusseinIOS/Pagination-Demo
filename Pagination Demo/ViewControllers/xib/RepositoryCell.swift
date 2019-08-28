//
//  RepositoryCell.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {
    
    @IBOutlet weak var watchersLbl: UILabel!
    @IBOutlet weak var forksCountLbl: UILabel!
    @IBOutlet weak var respositoryNameLbl: UILabel!
    @IBOutlet weak var repositoryUrlTxt: UITextView!
    @IBOutlet weak var descriptionLbl: UILabel!

    
    static let id = "RepositoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindOnData(_ repository: Repository){
        watchersLbl.text = (repository.watchers ?? 0).description
        forksCountLbl.text = (repository.forks ?? 0).description
        respositoryNameLbl.text = repository.fullName
        repositoryUrlTxt.attributedText = repository.htmlUrl?.clickableString(gotolink: repository.htmlUrl ?? "")
        repositoryUrlTxt.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        descriptionLbl.text = repository.description
    }
    
}
