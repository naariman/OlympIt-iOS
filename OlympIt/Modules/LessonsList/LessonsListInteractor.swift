//
//  LessonsListInteractor.swift
//  OlympIt
//
//  Created Nariman on 08.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class LessonsListInteractor: LessonsListInteractorProtocol {
    weak var presenter: LessonsListPresenterProtocol?
    private let repository: ILessonsRepository = LessonsRepositoryImpl()

    func fetchLessonsList(initialLessonType: InitialLessonType, type: LessonType, id: String) {
        repository.fetchLessonsList(initialLessonType: initialLessonType, type: type, id: id) { result in
            switch result {
            case .success(let response):
                self.presenter?.didFetchLessons(response: response)
            case .failure: break
            }
        }
    }
    
}
