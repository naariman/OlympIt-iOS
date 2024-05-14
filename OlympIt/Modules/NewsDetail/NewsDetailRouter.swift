//
//  NewsDetailRouter.swift
//  OlympIt
//
//  Created Nariman on 11.05.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import UIKit

final class NewsDetailRouter: NewsDetailWireframeProtocol {
    weak var viewController: UIViewController?
    
    static func createModule(news: NewsModel) -> UIViewController {
        // Change to get view from storyboard if not using progammatic UI
        let view = NewsDetailViewController(news: news)
        let interactor = NewsDetailInteractor()
        let router = NewsDetailRouter()
        let presenter = NewsDetailPresenter(interface: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view
        
        return view
    }
}
