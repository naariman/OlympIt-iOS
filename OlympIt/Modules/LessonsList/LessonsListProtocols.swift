//
//  LessonsListProtocols.swift
//  OlympIt
//
//  Created Nariman on 08.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import Foundation

//MARK: Wireframe -
protocol LessonsListWireframeProtocol: AnyObject {
    func openPdf(with url: URL)
}
//MARK: Presenter -
protocol LessonsListPresenterProtocol: AnyObject {
    var lessons: LessonsListOutput { get set }
    func viewDidLoad()
    func didSelect(at index: Int)
    func didFetchLessons(response: LessonsListOutput)
}

//MARK: Interactor -
protocol LessonsListInteractorProtocol: AnyObject {
  var presenter: LessonsListPresenterProtocol?  { get set }
    func fetchLessonsList(initialLessonType: InitialLessonType, type: LessonType, id: String)
}

//MARK: View -
protocol LessonsListViewProtocol: AnyObject {
  var presenter: LessonsListPresenterProtocol?  { get set }
    func reload()
}
