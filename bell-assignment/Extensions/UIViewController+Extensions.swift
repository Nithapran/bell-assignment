//
//  UIViewController+Extensions.swift
//  bell-assignment
//
//  Created by Nithaparan Francis on 2022-12-03.
//

import Foundation
import UIKit

extension UIViewController {
    func setUpNavigationBar(isHidden: Bool, titleView: UIView?) {
        
        if let titleView = titleView {
            navigationController?.navigationBar.topItem?.titleView = titleView
        }
        
        navigationController?.navigationBar.isHidden = isHidden
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.3764705882, blue: 0.08235294118, alpha: 1)
        appearance.titleTextAttributes =  [NSAttributedString.Key.foregroundColor : UIColor.white]
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
        
    }
}
