//
//  UIViewController+Extension.swift
//  etajerIOS
//
//  Created by mohamed on 7/30/19.
//  Copyright © 2019 Maxsys. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func alert(title: String, message: String, completion: (()->Void)?){
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default) { (_) in
            completion?()
        }
        
        alert.addAction(action)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
}
