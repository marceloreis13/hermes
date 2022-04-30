//
//  RepositoryView.swift
//  GithubGraphQL
//
//  Created by Marcelo Reis on 29/04/22.
//  Copyright © 2022 test. All rights reserved.
//
import Combine
import SwiftUI

struct RepositoryView: View {
    @ObservedObject private var repositoryViewModel = RepositoryViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Repositories(repos: repositoryViewModel.repositories)

                    LoaderView(state: repositoryViewModel.state)
                        .onAppear(perform: fetchData)
                        .onTapGesture(perform: fetchData)
                        .opacity(repositoryViewModel.state.shouldShowMessage ? 1 : 0)
                }
            }
            .navigationTitle("GitHub Repositories")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear(perform: fetchData)
        }
    }

    private func fetchData() {
        repositoryViewModel.getRepositories(phrase: "graphql")
    }
}

// MARK: - Subviews

struct Repositories: View {
    let repos: [RepositoryDetails]

    var body: some View {
        ForEach(repos.indices, id: \.self) { idx in
            RepositoryRow(repository: repos[idx])
        }
    }
}

struct RepositoryRow: View {
    let repository: RepositoryDetails

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            VStack(alignment: .leading) {
                ImageView(withURL: repository.owner.avatarUrl)
            }

            VStack(alignment: .leading, spacing: 16.0) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(repository.name)
                        .foregroundColor(.black)
                        .bold()

                    Text(repository.owner.login)
                        .foregroundColor(.black)
                        .italic()
                }

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)

                    Text("\(repository.stargazers.totalCount)")
                        .foregroundColor(.black)
                }
            }
        }
        .padding(10.0)
        .frame(height: 100.0, alignment: .leading)
    }
}

struct LoaderView: View {
    let state: RepoState

    var body: some View {
        Text(state.message)
            .foregroundColor(state.color)
            .padding()
    }
}

struct ImageView: View {
    @State var url: String

    init(withURL url: String) {
        self.url = url
    }

    var body: some View {
        if let url = URL(string: url) {
            AsyncImage(url: url,
                       placeholder: { Text("...") },
                       image: { Image(uiImage: $0).resizable() })
                .frame(width: 50, height: 50)
                .clipShape(Circle())
        }
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryView()
    }
}
