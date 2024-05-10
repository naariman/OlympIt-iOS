//
//  DashboardViewController.swift
//  OlympIt
//
//  Created Nariman on 18.02.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit
import SnapKit
import BetterSegmentedControl

final class DashboardViewController: UIViewController,
                                     DashboardViewProtocol {
    
    enum Constants {
        static let subtitleText = "Что будем учить сегодня?"
        static let welcome = "Добро пожаловать!"
        static let materials = "Материалы"
    }

	var presenter: DashboardPresenterProtocol?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.text = Constants.welcome
        label.textColor = .white
        return label
    }()
    
    private let segmentedControl = BetterSegmentedControl(
        frame: .zero,
        segments: LabelSegment.segments(
            withTitles: InitialLessonType.allCases.map { $0.dashboardTitle },
            normalFont: .systemFont(ofSize: 18, weight: .semibold),
            normalTextColor: ._727274,
            selectedFont: .systemFont(ofSize: 18, weight: .semibold),
            selectedTextColor: .white
        ),
        options:[.backgroundColor(._1E1E1E),
                 .indicatorViewBackgroundColor(._404043),
        .cornerRadius(12.0),
        .animationSpringDamping(1.5)]
    )
    
    private let lessonsTitleLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.materials
        label.textColor = .white
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 120, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = ._37343B
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        collectionView.register(LessonCollectionViewCell.self)
        return collectionView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

	override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    func reloadData() {
        hideLoadingAnimation()
        collectionView.reloadData()
    }
    
    func showAlert(message: String) {
        self.alert(message: message)
    }
}

// MARK: Setup UI
private extension DashboardViewController {
    
    func setupNavigationBar() {
        setLeftAlignedNavigationItemTitle(
            text: Constants.welcome,
            color: .white
        )
    }
    
    func setupUI() {
        navBar(title: "Материалы")
        view.backgroundColor = ._37343B
        view.addSubviews(
            segmentedControl,
            lessonsTitleLabel,
            collectionView
        )
    
        segmentedControl.addTarget(
            self,
            action: #selector(
                DashboardViewController.navigationSegmentedControlValueChanged
            ),
            for: .valueChanged
        )
    
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(50)
        }
        
        lessonsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(24)
            make.leading.equalTo(16)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(lessonsTitleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
    }
    
}

// MARK: - Segmented Control processing
private extension DashboardViewController {
    func configureData() {}
    
    @objc func navigationSegmentedControlValueChanged(_ sender: BetterSegmentedControl) {
        if sender.index == 0 {
            presenter?.lessonType = .olymp
        } else {
            presenter?.lessonType = .exam
        }
    }
}

// MARK: - UICollectionView
extension DashboardViewController: UICollectionViewDataSource,
                                   UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.lessons.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let presenter else { return UICollectionViewCell() }
        let cell: LessonCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configure(lessonModel: presenter.lessons[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelectItem(at: indexPath.row)
    }
}
