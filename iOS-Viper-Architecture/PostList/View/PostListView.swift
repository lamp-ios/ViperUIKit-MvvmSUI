//
//  PostListView.swift
//  iOS-Viper-Architecture
//
//  Created by gnkiriy on 07.10.2023.
//  Copyright © 2023 Mindorks NextGen Private Limited. All rights reserved.
//

import SwiftUI
import Kingfisher

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

struct PostListView: View {
    @StateObject var viewModel: PostListViewModel

    var body: some View {
        List {
            switch viewModel.state.posts {
            case .none:
                EmptyView()
            case .loading:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case let .loaded(.success(posts)):
                ForEach(posts) { post in
                    Button {
                        viewModel.perform(action: .showDetail(post: post))
                    } label: {
                        HStack {
                            KFImage(URL(string: post.thumbImageUrl))
                                .resizable()
                                .placeholder {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)
                            VStack {
                                Text(post.title)
                            }
                        }
                    }
                }
            case .loaded(.failure):
                Text("Some error happened")
            }
        }.onAppear {
            viewModel.perform(action: .viewLoad)
        }.navigationTitle("Posts")
    }
}

#Preview {
    PostListView(viewModel: .init(
        state: .init(posts: .loading),
        performAction: { dump($0) }
    ))
}
