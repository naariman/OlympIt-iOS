//
//  PdfPresenter.swift
//  OlympIt
//
//  Created Nariman on 10.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class PdfPresenter: PdfPresenterProtocol {
    weak private var view: PdfViewProtocol?
    var interactor: PdfInteractorProtocol?
    private let router: PdfWireframeProtocol
    private let url: URL
    init(interface: PdfViewProtocol, interactor: PdfInteractorProtocol?, router: PdfWireframeProtocol, url: URL) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.url = url
    }
    
    func viewDidLoad() {}
    
    func getUrl() -> URL {
        url
    }
}
