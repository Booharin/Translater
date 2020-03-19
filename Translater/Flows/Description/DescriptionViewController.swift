//
//  DescriptionViewController.swift
//  Translater
//
//  Created by 18421820 on 19.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import UIKit
import SnapKit

class DescriptionViewController: UIViewController {
    
    var meaning: TranslateMeaning?
    private var wordImageView = UIImageView()
    private var descriptionLabel = UILabel()
    
    private var environment: Environment {
        return EnvironmentImp.Release()
    }
    
    lazy var translateService: TranslateService? = {
        let translateService = TranslateService(environment: environment)
        return translateService
    }()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = #colorLiteral(red: 0.7410152555, green: 0.6895774007, blue: 1, alpha: 1)
        addImageView()
        addLabelView()
        
        guard
            let urlDescription = meaning?.imageUrl,
            let imageUrl = URL(string: "https:\(urlDescription)") else { return }
        
        downloadImage(from: imageUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    private func addImageView() {
        wordImageView.contentMode = .scaleAspectFit
        view.addSubview(wordImageView)
        wordImageView.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(80)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(480)
        }
    }
    
    private func addLabelView() {
        view.addSubview(descriptionLabel)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.snp.makeConstraints() {
            $0.top.equalTo(wordImageView.snp.bottom).offset(20)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
        }
        
        descriptionLabel.text = meaning?.translation.text ?? ""
    }
    
    private func downloadImage(from url: URL) {
        translateService?.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.wordImageView.image = UIImage(data: data)
            }
        }
    }
}
