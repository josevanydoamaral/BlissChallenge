//
//  ViewController.swift
//  BlissChallenge
//
//  Created by Josevany on 22/10/2026.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    let getEmojiButon: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Emoji", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(getEmojiButon)
        
        NSLayoutConstraint.activate([
            getEmojiButon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            getEmojiButon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getEmojiButon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            getEmojiButon.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }


}

#Preview {
    return HomeViewController()
}
