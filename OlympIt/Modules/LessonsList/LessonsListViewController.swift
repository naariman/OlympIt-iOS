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
    
    var completion: (URL) -> () = {_ in}
    
    private let stackButtons = SegmentButton(frame: .zero)
    
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
        stackButtons.tenClassTapped = { [weak self] in
            guard let self = self else {return}
            self.presenter?.changeType(type: self.presenter?.type == .practice ? .practice10 : .theory10)
            self.presenter?.viewDidLoad()
        }
        stackButtons.elevenClassTapped = { [weak self] in
            guard let self = self else {return}
            self.presenter?.changeType(type: self.presenter?.type == .practice10 ? .practice : .theory)
            self.presenter?.viewDidLoad()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        DispatchQueue.main.async {
            self.searchController.isActive = true
        }
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupViews() {
        view.backgroundColor = ._37343B
        tableView.backgroundColor = ._37343B
        view.addSubview(stackButtons)
        view.addSubview(tableView)
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
        stackButtons.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(25)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.top.equalTo(stackButtons.snp.bottom)
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
        presenter?.search(searchText: "")
    }
}

class SegmentButton: UIView {
    var eleventhSelected: Bool = true
    var elevenClassTapped: () -> () = {}
    var tenClassTapped: () -> () = {}
    private let stackButtons: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 11
        stack.distribution = .fillEqually
        stack.alignment = .center
        return stack
    }()
    
    private let button: UIButton = {
       let button = UIButton()
        button.setTitle("11 класс", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = ._404043
        return button
    }()
    
    private let secondButton: UIButton = {
       let button = UIButton()
        button.setTitle("10 класс", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .systemFont(ofSize: 13)
        button.setTitleColor(._727274, for: .normal)
        button.backgroundColor = ._252527
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func tenthClassAction() {
        tenClassTapped()
        if eleventhSelected {
            eleventhSelected.toggle()
        }
        configureButtons()
    }
    
    @objc
    private func eleventhClassAction() {
        elevenClassTapped()
        if !eleventhSelected {
            eleventhSelected.toggle()
        }
        configureButtons()
    }
    
    private func configureButtons() {
        if eleventhSelected {
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = ._404043
            secondButton.setTitleColor(._727274, for: .normal)
            secondButton.backgroundColor = ._252527
        } else {
            button.setTitleColor(._727274, for: .normal)
            button.backgroundColor = ._252527
            secondButton.setTitleColor(.white, for: .normal)
            secondButton.backgroundColor = ._404043
        }
    }
    
    private func setupUI() {
        addSubview(stackButtons)
        [button, secondButton].forEach { stackButtons.addArrangedSubview($0)}
        
        button.snp.makeConstraints { make in
            make.height.equalTo(21)
        }
        
        secondButton.snp.makeConstraints { make in
            make.height.equalTo(21)
        }
        
        stackButtons.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        button.addTarget(self, action: #selector(eleventhClassAction), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(tenthClassAction), for: .touchUpInside)
//        [button, secondButton].forEach {
//            $0.snp.makeConstraints { make in
//                make.edges
//            }
//        }
    }
}
