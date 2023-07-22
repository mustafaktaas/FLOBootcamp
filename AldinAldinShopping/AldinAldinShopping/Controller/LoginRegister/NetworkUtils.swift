//
//  NetworkUtils.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 9.07.2023.
//

import Foundation
import UIKit

class NetworkUtils {
    static func checkConnection(in viewController: UIViewController, retryButtonTapped: @escaping () -> Void) {
        if !NetworkUtility.checkNetworkConnectivity() {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default) { _  in
                    retryButtonTapped()
                }
                alert.addAction(retryAction)
                viewController.present(alert, animated: true, completion: nil)
            }
            return
        }
    }

    static func retryButtonTapped(in viewController: UIViewController) {
        if NetworkUtility.checkNetworkConnectivity() {
            viewController.dismiss(animated: true) {
            }
        } else {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default) { _  in
                retryButtonTapped(in: viewController)
            }
            alert.addAction(retryAction)
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}


