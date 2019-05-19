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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
