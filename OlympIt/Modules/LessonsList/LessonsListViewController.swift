//
//  LessonsListViewController.swift
//  OlympIt
//
//  Created Nariman on 08.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class LessonsListViewController: UIViewController,
                                       LessonsListViewProtocol, UISearchControllerDelegate {
	var presenter: LessonsListPresenterProtocol?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LessonDetailsCell.self)
        return tableView
    }()
    
    private var searchController: UISearchController = {
        let viewController = UISearchController(searchResultsController: nil)
        return viewController
    }()
    
    
	override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = ._37343B
        tableView.backgroundColor = ._37343B
        view.addSubview(tableView)
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.searchController = searchController
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.placeholder = "Что вы хотите найти?"
        searchController.searchBar.searchTextField.tintColor = .white
        searchController.searchBar.barStyle = .black
        searchController.searchBar.searchTextField.textColor = .white
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension LessonsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.lessons.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let presenter else { return UITableViewCell() }
        let cell: LessonDetailsCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(model: presenter.lessons[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let presenter else { return }
        presenter.didSelect(at: indexPath.row)
    }
}

extension LessonsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.search(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
}
