//
//  DashboardPresenter.swift
//  OlympIt
//
//  Created Nariman on 18.02.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class DashboardPresenter {
    weak private var view: DashboardViewProtocol?
    var interactor: DashboardInteractorProtocol?
    private let router: DashboardWireframeProtocol
    private var selectedIndex = -1
    
    var lessons: InitialLessonOutputList = []

    var lessonType: InitialLessonType = .olymp {
        didSet {
            interactor?.fetchExams(by: lessonType)
        }
    }
    
    init(interface: DashboardViewProtocol, interactor: DashboardInteractorProtocol?, router: DashboardWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
    }
}

extension DashboardPresenter: DashboardPresenterProtocol {
    
    func viewDidLoad() {
        lessonType = .olymp
    }
    
    func didFetchLessons(with lessons: InitialLessonOutputList) {
        self.lessons.removeAll()
        self.lessons = lessons
        view?.reloadData()
    }
    
    func error(message: String) {
        view?.showAlert(message: message)
    }
    
    func didSelectItem(at index: Int) {
        selectedIndex = index
        router.openBottomSheet(executor: self)
    }
}

extension DashboardPresenter: SelectableBottomSheetDelegate {
    func didSelect(type: LessonType) {
        router.openLessonsList(initialLessonType: lessonType, type: type, lessonId: lessons[selectedIndex].id)
    }
}
