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
                                       LessonsListViewProtocol {
	var presenter: LessonsListPresenterProtocol?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LessonDetailsCell.self)
        return tableView
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
        setupLeftNavigationBar(title: "Материалы", backButtonImage: UIImage(named: "chevron.left"))
        view.backgroundColor = ._37343B
        tableView.backgroundColor = ._37343B
        view.addSubview(tableView)
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
}
