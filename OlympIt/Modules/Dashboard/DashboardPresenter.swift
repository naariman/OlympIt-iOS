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
    
    var examLessons: Lessons = [] {
        didSet {
            view?.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.view?.reloadData()
            }
        }
    }
    
    var olympLessons: Lessons = [] {
        didSet {
            view?.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.view?.reloadData()
            }
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
        fetchOlymp()
    }
    
    func fetchExam() {
        examLessons = LessonModel.examsMock
    }
    
    func fetchOlymp() {
        examLessons = LessonModel.olympMock
    }
}
