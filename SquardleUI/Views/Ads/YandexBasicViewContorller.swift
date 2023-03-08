//
//  YandexBasicViewContorller.swift
//  SquardleUI
//
//  Created by Сергей Дубовой on 08.03.2023.
//

import Foundation
import SwiftUI

class YandexBasicVC: UIViewController {
    var spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var dismissClosure: (() -> ())!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)

        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.color = UIColor(white: 0.5, alpha: 1)
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
