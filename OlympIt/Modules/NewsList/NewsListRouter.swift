//
//  NewsListRouter.swift
//  OlympIt
//
//  Created Nariman on 11.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class NewsListRouter: NewsListWireframeProtocol {
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = NewsListViewController()
        let interactor = NewsListInteractor()
        let router = NewsListRouter()
        let presenter = NewsListPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    func openNewsDetail(with model: NewsModel) {
        let vc = NewsDetailRouter.createModule(news: model)
        viewController?.pushIfPossibleOrPresent(viewController: vc, animated: true, completion: nil)
    }
}
