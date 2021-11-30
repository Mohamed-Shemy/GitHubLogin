//
//  SearchViewController.swift
//  GitHubLogin
//
//  Created by Mohamed Shemy on Tue 30 Nov, 2021.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Properties
    
    private let viewModel = GitHubSearchViewModel()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Setup
    
    private func setup() {
        setupUserTableView()
        bindData()
    }
    
    private func setupUserTableView() {
        userTableView.register(nib: UserTableViewCell.self)
        userTableView.rowHeight = 60
        userTableView.tableFooterView = UIView()
    }
    
    // MARK: - Binding
    
    private func bindData() {
        bindSearchTextField()
        bindSubmitButton()
        bindUserTableView()
        handleErrorMessage()
    }
    
    private func bindSearchTextField() {
        searchTextField.rx.text.orEmpty
            .bind(to: viewModel.searchText)
            .disposed(by: viewModel.disposeBag)
        
        // bind return button action to submit search
        searchTextField.rx.controlEvent(.editingDidEndOnExit)
            .bind(to: viewModel.submitButtonTapped)
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindSubmitButton() {
        submitButton.rx.tap
            .bind(to: viewModel.submitButtonTapped)
            .disposed(by: viewModel.disposeBag)
    }
    
    private func bindUserTableView() {
        userTableView.rx
            .willDisplayCell // subscribe on will display event
            .subscribe(onNext: { [weak self] willDisplEvent in
                guard let self = self else { return }
                // check if the cell is the last one & get next page, if it is
                if willDisplEvent.indexPath.row == (self.viewModel.users.value.count - 1) {
                    self.viewModel.getNextPage()
                }
            }).disposed(by: viewModel.disposeBag)
        
        /*
         * GitHub search does not provide a sort alphabetically option.
         * Sorting results will cause a bad behavior with pagination,
           after getting a new page some rows will raise-up.
         */
        viewModel.users
            .map({
                $0.compactMap(\.uiModel)    // map user to ui user
                    .sorted(by: \.login, <) // sort result by login
            })
            .bind(to: userTableView.rx // bind data into tableview
                    .items(cellIdentifier: UserTableViewCell.identifier,
                           cellType: UserTableViewCell.self)) { (indexPath, user, cell) in
                cell.configure(with: user)
            }.disposed(by: viewModel.disposeBag)
    }
    
    private func handleErrorMessage() {
        viewModel.error.subscribe(onNext: { [weak self] message in
            self?.displyErrorAlert(with: message)
        }).disposed(by: viewModel.disposeBag)
    }
    
    // MARK: - Helper Methods
    
    private func displyErrorAlert(with message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

/*
 
 We can use 'UISearchController' and onChange event with delay 0.5 sec
 without the submitButton
 
 private func setupSearchController() {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchBar.placeholder = "login"
    navigationItem.searchController = searchController
 
    searchController.searchBar
        .rx.text.orEmpty
        .debounce(.milliseconds(500), scheduler: MainScheduler.instance)
        .distinctUntilChanged()
        .bind(to: viewModel.searchText) // subscribe on searchText in the viewModel
        .disposed(by: viewModel.disposeBag)
 }
 
 */
