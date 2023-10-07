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
    let interactor: PostListInteractorInputProtocol
    let wireFrame: PostListWireFrameProtocol

    init(interactor: PostListInteractorInputProtocol, wireFrame: PostListWireFrameProtocol, state: PostListState) {
        self.interactor = interactor
        self.wireFrame = wireFrame
        self.state = state
    }

    var state: PostListState = .init() {
        didSet {
            view?.update(with: state)
        }
    }

    func perform(action: PostListAction) {
        switch action {
        case .viewLoad:
            state.posts = .loading
            interactor.retrievePostList()
        case let .showDetail(post):
            wireFrame.presentPostDetailScreen(forPost: post)
        }
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


