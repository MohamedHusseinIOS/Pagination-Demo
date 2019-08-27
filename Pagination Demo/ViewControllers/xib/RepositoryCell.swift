//
//  RepositoryCell.swift
//  The D. Gmbh Task
//
//  Created by Mohamed Hussien on 27/08/2019.
//  Copyright © 2019 HNF. All rights reserved.
//

import UIKit

class RepositoryCell: UITableViewCell {

    @IBOutlet weak var respositoryName: UILabel!
    @IBOutlet weak var repositoryUrl: UILabel!
    
    static let id = "RepositoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bindOnData(_ repository: Repository){
        respositoryName.text = repository.fullName
        repositoryUrl.attributedText = repository.url?.clickableString(gotolink: repository.url ?? "")
    }

}
