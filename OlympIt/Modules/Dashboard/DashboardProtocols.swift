//
//  DashboardProtocols.swift
//  OlympIt
//
//  Created Nariman on 18.02.2024.
//  Copyright © 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  Template generated by Dastan Makhutov @mchutov
//

import Foundation

//MARK: Wireframe -
protocol DashboardWireframeProtocol: AnyObject {

}
//MARK: Presenter -
protocol DashboardPresenterProtocol: AnyObject {

}

//MARK: Interactor -
protocol DashboardInteractorProtocol: AnyObject {
  var presenter: DashboardPresenterProtocol?  { get set }
}

//MARK: View -
protocol DashboardViewProtocol: AnyObject {
    var presenter: DashboardPresenterProtocol?  { get set }
    func setupUI()
}
