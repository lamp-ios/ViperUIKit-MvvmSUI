//
//  PostListWireFrame.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 18/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

import UIKit
import SwiftUI

class PostListWireFrame: PostListWireFrameProtocol {
    class func createPostListModule(state: PostListState = .init()) -> UIViewController {
        if FeatureToggles.suiPostList {
            createPostListModuleSui(state: state)
        } else {
            createPostListModuleUIKit(state: state)
        }
    }

    class func createPostListModuleUIKit(state: PostListState = .init()) -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "PostsNavigationController")
        if let viewController = navController.childViewControllers.first as? PostListViewController {
            let wireFrame = PostListWireFrame()

            let localDataManager: PostListLocalDataManagerInputProtocol = PostListLocalDataManager()
            let remoteDataManager: PostListRemoteDataManagerInputProtocol = PostListRemoteDataManager()

            let interactor = PostListInteractor(
                localDatamanager: localDataManager,
                remoteDatamanager: remoteDataManager
            )

            let presenter = PostListPresenter(
                interactor: interactor,
                wireFrame: wireFrame,
                state: state
            )

            wireFrame.viewController = viewController
            viewController.presenter = presenter
            presenter.view = viewController
            interactor.presenter = presenter
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }

    class func createPostListModuleSui(state: PostListState = .init()) -> UIViewController {
        let wireFrame = PostListWireFrame()

        let localDataManager: PostListLocalDataManagerInputProtocol = PostListLocalDataManager()
        let remoteDataManager: PostListRemoteDataManagerInputProtocol = PostListRemoteDataManager()

        let interactor = PostListInteractor(
            localDatamanager: localDataManager,
            remoteDatamanager: remoteDataManager
        )

        let presenter = PostListPresenter(
            interactor: interactor,
            wireFrame: wireFrame,
            state: state
        )

        let viewModel = PostListViewModel(state: presenter.state, performAction: presenter.perform)
        let view = PostListView(viewModel: viewModel)
        let viewController = UIHostingController(rootView: view)

        wireFrame.viewController = viewController
        presenter.view = viewModel
        interactor.presenter = presenter
        remoteDataManager.remoteRequestHandler = interactor

        return UINavigationController(rootViewController: viewController)
    }

    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
    weak var viewController: UIViewController?

    func presentPostDetailScreen(forPost post: PostModel) {
        let postDetailViewController = PostDetailWireFrame.createPostDetailModule(forPost: post)
   
        if let viewController {
            viewController.navigationController?.pushViewController(postDetailViewController, animated: true)
        }
    }
    
}
