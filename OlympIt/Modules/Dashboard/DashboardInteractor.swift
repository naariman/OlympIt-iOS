//
//  DashboardInteractor.swift
//  OlympIt
//
//  Created Nariman on 18.02.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class DashboardInteractor {
    weak var presenter: DashboardPresenterProtocol?
    private let repository: ILessonsRepository = LessonsRepositoryImpl()
}

extension DashboardInteractor: DashboardInteractorProtocol {
    func fetchExams(by type: InitialLessonType) {
        repository.fetchInitialLessons(by: type) { result in
            switch result {
            case .success(let response):
                self.presenter?.didFetchLessons(with: response)
            case .failure(let error):
                self.presenter?.error(message: error.localizedDescription)
            }
        }
    }
    
    func getNews() {
        repository.getNews() { result in
            switch result {
            case .success(let response):
                self.presenter?.didGetNews(with: response)
            case .failure(let error):
                self.presenter?.error(message: error.localizedDescription)
            }
        }
    }
}
