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
            GeometryReader { geometry in
                ZStack {
                    List {
                        Repositories(repos: repositoryViewModel.repositories, geometry: geometry)

                        LoaderView(isFailed: repositoryViewModel.isRequestFailed,
                                   hasNextPage: repositoryViewModel.hasNextPage)
                            .onAppear(perform: fetchData)
                            .onTapGesture(perform: onTapLoadView)
                    }
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

    private func onTapLoadView() {
        if repositoryViewModel.isRequestFailed {
            repositoryViewModel.isRequestFailed = false
            fetchData()
        }
    }
}

// MARK: - Subviews

struct Repositories: View {
    let repos: [RepositoryDetails]
    let geometry: GeometryProxy

    var body: some View {
        ForEach(repos.indices, id: \.self) { idx in
            RepositoryRow(repository: repos[idx], geometry: geometry)
        }
    }
}

struct RepositoryRow: View {
    let repository: RepositoryDetails
    let geometry: GeometryProxy

    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                ImageView(withURL: repository.owner.avatarUrl)
                Spacer()
            }
            .padding(.leading, 20.0)
            .padding(.trailing, 8.0)

            VStack(alignment: .leading, spacing: 10.0) {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(repository.name)
                        .foregroundColor(.black)
                        .bold()

                    Text(repository.owner.login)
                        .foregroundColor(.black)
                        .italic()
                }
                .padding(.trailing, 60)

                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.black)

                    Text("\(repository.stargazers.totalCount)")
                        .foregroundColor(.black)
                }

                Spacer()
            }
        }
        .padding(.top, 16.0)
        .frame(width: geometry.size.width - 16.0, height: 100.0, alignment: .leading)
        .padding(.leading, 10.0)
    }
}

struct LoaderView: View {
    let isFailed: Bool
    let hasNextPage: Bool

    var body: some View {
        if hasNextPage {
            Text(isFailed ? "Failed. Tap to retry." : "Loading..")
                .foregroundColor(isFailed ? .red : .green)
                .padding()
        }
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
                       placeholder: { Text("Loading ...") },
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
