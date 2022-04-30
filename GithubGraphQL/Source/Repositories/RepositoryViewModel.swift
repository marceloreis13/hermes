//
//  RepositoryViewModel.swift
//  GithubGraphQL
//
//  Created by Marcelo Reis on 29/04/22.
//  Copyright © 2022 test. All rights reserved.
//

import Apollo
import Combine
import SwiftUI
import Foundation

enum RepoState {
    case loading
    case success
    case failure
    case empty

    var shouldShowMessage: Bool {
        self != .success
    }

    var message: String {
        switch self {
        case .loading:
            return "Loading..."
        case .success:
            return ""
        case .failure:
            return "Failed. Tap to retry."
        case .empty:
            return "We couldn’t find any repository"
        }
    }

    var color: Color {
        switch self {
        case .loading:
            return .green
        case .success:
            return .white.opacity(0)
        case .failure:
            return .red
        case .empty:
            return .blue
        }
    }
}

class RepositoryViewModel: ObservableObject {
    @Published public var repositories: [RepositoryDetails] = []
    @Published public var state: RepoState = .success
    @Published public var hasNextPage = true
    private let pageLimit = 20
    private var cancellable: Apollo.Cancellable?
    private let client: GraphQLClient
    public var cursor: Cursor?

    init(client: GraphQLClient = ApolloClient.shared) {
        self.client = client
    }

    deinit {
        cancellable?.cancel()
    }

    public func getRepositories(phrase: String) {
        guard hasNextPage else { return }
        guard state != .loading else { return }

        state = .loading
        let filter = SearchRepositoriesQuery.Filter.after(cursor, limit: pageLimit)
        cancellable = client.searchRepositories(mentioning: phrase, filter: filter) { [weak self] response in
            guard let self = self else { return }

            switch response {
            case let .failure(error):
                self.state = .failure
                print(error)

            case let .success(results):
                self.repositories.append(contentsOf: results.repos)
                if let endCursor = results.pageInfo.endCursor {
                    self.cursor = Cursor(rawValue: endCursor)
                }
                self.hasNextPage = results.pageInfo.hasNextPage
                self.state = self.repositories.isEmpty ? .empty : .success
            }
        }
    }
}
