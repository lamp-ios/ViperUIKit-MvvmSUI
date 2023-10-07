//
//  PostListProtocols.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 18/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

import UIKit

enum LoadingState<Value, Failure: Error> {
    case loading
    case loaded(Result<Value, Failure>)
}

struct PostListState {
    var posts: LoadingState<[PostModel], Error>?
}

enum PostListAction {
    case viewLoad
    case showDetail(post: PostModel)
}

protocol PostListViewProtocol: class {
    // PRESENTER -> VIEW
    func update(with state: PostListState)
}

protocol PostListWireFrameProtocol: class {
    static func createPostListModule(state: PostListState) -> UIViewController
    // PRESENTER -> WIREFRAME
    func presentPostDetailScreen(forPost post: PostModel)
}

protocol PostListPresenterProtocol: class {
    // VIEW -> PRESENTER
    func perform(action: PostListAction)
}

protocol PostListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [PostModel])
    func onError()
}

protocol PostListInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    func retrievePostList()
}

protocol PostListDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol PostListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: PostListRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostList()
}

protocol PostListRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsRetrieved(_ posts: [PostModel])
    func onError()
}

protocol PostListLocalDataManagerInputProtocol: class {
     // INTERACTOR -> LOCALDATAMANAGER
    func retrievePostList() throws -> [Post]
    func savePost(id: Int, title: String, imageUrl: String, thumbImageUrl: String) throws
}
