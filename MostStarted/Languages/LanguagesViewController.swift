//
//  LanguagesViewController.swift
//  MostStarted
//
//  Created by Mustafa Ozhan on 19/05/2019.
//  Copyright © 2019 Mustafa Ozhan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LanguagesViewController: UIViewController, StoryboardInitializable {
    
    @IBOutlet private weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    var viewModel: LanguagesViewModel!
    
    private let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    private func setupUI() {
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.title = "Choose a language"
        
        tableView.rowHeight = 48.0
    }
    
    private func setupBindings() {
        viewModel.languages
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(
                cellIdentifier: "LanguageCell",
                cellType: UITableViewCell.self)
            ) { (_, language, cell) in
                cell.textLabel?.text = language
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind(to: viewModel.selectLanguage)
            .disposed(by: disposeBag)
        
        cancelButton.rx.tap
            .bind(to: viewModel.cancel)
            .disposed(by: disposeBag)
    }
}
