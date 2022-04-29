//
//  RepositoryViewModel.swift
//  GithubGraphQL
//
//  Created by Marcelo Reis on 29/04/22.
//  Copyright © 2022 test. All rights reserved.
//

import SwiftUI
import Combine
import Apollo

class RepositoryViewModel: ObservableObject {
    @Published public var repositories: [RepositoryDetails] = []
    @Published public var isRequestFailed = false
    @Published public var hasNextPage = true
    private let pageLimit = 20
    private var cancellable = Set<AnyCancellable>()
    private let client: GraphQLClient
    private var cursor: Cursor?

    init(client: GraphQLClient = ApolloClient.shared) {
        self.client = client
    }
    
    public func getRepositories(phrase: String) {
        guard hasNextPage else { return }
        
        let filter = SearchRepositoriesQuery.Filter.after(cursor, limit: pageLimit)
        client.searchRepositories(mentioning: phrase, filter: filter) { [weak self] response in
            guard let self = self else { return }
            
            switch response {
            case let .failure(error):
                self.isRequestFailed = true
                print(error)
                
            case let .success(results):
                self.repositories.append(contentsOf: results.repos)
                let pageInfo = results.pageInfo
                if let endCursor = pageInfo.endCursor {
                    self.cursor = Cursor(rawValue: endCursor)
                }
                self.hasNextPage = pageInfo.hasNextPage
            }
        }
        
    }
}

