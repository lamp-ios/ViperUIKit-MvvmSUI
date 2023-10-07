//
//  PostListPresenter.swift
//  iOS-Viper-Architecture
//
//  Created by Amit Shekhar on 18/02/17.
//  Copyright © 2017 Mindorks NextGen Private Limited. All rights reserved.
//

extension String: Error {}

class PostListPresenter: PostListPresenterProtocol {
    weak var view: PostListViewProtocol?
    var interactor: PostListInteractorInputProtocol?
    var wireFrame: PostListWireFrameProtocol?
    var state: PostListState = .init() {
        didSet {
            view?.update(with: state)
        }
    }

    func viewDidLoad() {
        state.posts = .loading
        interactor?.retrievePostList()
    }
    
    func showPostDetail(forPost post: PostModel) {
        wireFrame?.presentPostDetailScreen(from: view!, forPost: post)
    }

}

extension PostListPresenter: PostListInteractorOutputProtocol {
    func didRetrievePosts(_ posts: [PostModel]) {
        state.posts = .loaded(.success(posts))
    }
    
    func onError() {
        state.posts = .loaded(.failure("Что-то пошло не так"))
    }
}


