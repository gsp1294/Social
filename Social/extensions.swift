//
//  extensions.swift
//  Social
//
//  Created by Gayatri Patil on 09/04/18.
//  Copyright © 2018 Gayatri Patil. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(title: String?,message : String?, actionTitle : String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: actionTitle, style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
