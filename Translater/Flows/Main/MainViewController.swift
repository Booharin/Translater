//
//  MainViewController.swift
//  Translater
//
//  Created by 18421820 on 17.03.2020.
//  Copyright © 2020 Umbrella. All rights reserved.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
    var toWordDescription: ((TranslateMeaning) -> (Void))?

    private var wordTextField = UITextField()
    private var tableView = UITableView()
    private let loadingView = UIActivityIndicatorView(style: .medium)
    
    var coordinator: MainCoordinator?
    private var translateMeanings: [TranslateMeaning]?
    private let rowHeight: CGFloat = 64
    
    private var environment: Environment {
        return EnvironmentImp.Release()
    }
    
    lazy var translateService: TranslateService? = {
        let translateService = TranslateService(environment: environment)
        return translateService
    }()
    
    override func loadView() {
        super.loadView()

        view.backgroundColor = #colorLiteral(red: 0.8438377976, green: 0.8120523691, blue: 1, alpha: 1)
        addWordTextField()
        addTableView()
        
        view.addSubview(loadingView)
        loadingView.hidesWhenStopped = true
        loadingView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func addWordTextField() {
        wordTextField.borderStyle = .roundedRect
        wordTextField.returnKeyType = .done
        wordTextField.delegate = self
        
        wordTextField.addTarget(self,
                                action: #selector(textFieldDidChange),
                                for: .editingChanged)
        
        view.addSubview(wordTextField)
        wordTextField.snp.makeConstraints() {
            $0.top.equalToSuperview().offset(60)
            $0.height.equalTo(60)
            $0.leading.equalTo(20)
            $0.trailing.equalTo(-20)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        loadingView.startAnimating()
        
        translateService?.translate(word: textField.text ?? "") { [weak self] meanings in
            DispatchQueue.main.async {
                self?.loadingView.stopAnimating()
                guard let translateMeanings = meanings else { return }
                self?.translateMeanings = translateMeanings
                self?.tableView.reloadData()
            }
        }
    }
    
    private func addTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints() {
            $0.top.equalTo(wordTextField.snp.bottom).offset(60)
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return translateMeanings?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = translateMeanings?[indexPath.row].translation.text
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let meaning = translateMeanings?[indexPath.row] else { return }
        toWordDescription?(meaning)
    }
}

extension MainViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
