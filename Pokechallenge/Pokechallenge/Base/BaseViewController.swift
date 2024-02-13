//
//  BaseViewController.swift
//  Pokechallenge
//
//  Created by André Silva on 13/02/2024.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated) }
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated) }
    override func viewDidDisappear(_ animated: Bool) { super.viewDidDisappear(animated) }
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated) }
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }

    func showAlert(with title: String, message: String, actions: NSArray?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        if let actions = actions {
            for action in actions {
                if let actionToBeAdded = action as? UIAlertAction {
                    alert.addAction(actionToBeAdded)
                }
            }
        } else {
            alert.addAction(UIAlertAction(title: (.okAlertAction), style: UIAlertAction.Style.default, handler: nil))
        }

        self.present(alert, animated: true, completion: nil)
    }
}
// MARK: - Constants
private extension String {
    static let okAlertAction = "Ok"
}
