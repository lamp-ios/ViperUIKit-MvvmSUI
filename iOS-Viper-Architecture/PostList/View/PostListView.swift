//
//  PostListView.swift
//  iOS-Viper-Architecture
//
//  Created by gnkiriy on 07.10.2023.
//  Copyright © 2023 Mindorks NextGen Private Limited. All rights reserved.
//

import SwiftUI

final class PostListViewModel: ObservableObject, PostListViewProtocol {
    private let performAction: (PostListAction) -> Void

    @Published
    var state: PostListState

    init(
        state: PostListState = .init(),
        performAction: @escaping (PostListAction) -> Void
    ) {
        self.state = state
        self.performAction = performAction
    }

    func update(with state: PostListState) {
        self.state = state
    }

    func perform(action: PostListAction) {
        performAction(action)
    }
}
