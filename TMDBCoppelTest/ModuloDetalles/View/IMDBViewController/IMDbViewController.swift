//
//  IMDbViewController.swift
//  TMDBCoppelTest
//
//  Created by Jael  on 02/03/23.
//

import Foundation
import UIKit
import WebKit

class IMDBViewController: UIViewController {
    
    let webView = WKWebView()
    let dismissButton = UIButton(type: .system)
    let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        dismissButton.backgroundColor = .black
        dismissButton.setTitleColor(.systemGreen, for: .normal)
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(webView)
        stackView.addArrangedSubview(dismissButton)
        
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    func loadIMDBPage(for movie: String) {
        let imdbURL = URL(string: "https://www.imdb.com/find?q=\(movie)")!
        webView.load(URLRequest(url: imdbURL))
    }
    
    @objc func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
    
}
