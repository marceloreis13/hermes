@testable import GithubGraphQL
import XCTest

class GithubGraphQLTests: XCTestCase {

    var qtdNodes: UInt = 5
    var mockedResponse: SearchRepositoriesQuery.Data {
        let mockedResponse = SearchRepositoriesQuery.Data(search: .init(
            pageInfo: .init(startCursor: "startCursor", endCursor: nil, hasNextPage: false, hasPreviousPage: false),
            edges: makeEdges(count: qtdNodes)
        ))
        
        return mockedResponse
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - Request Repositories
    func testGetRepositories_WhenRequestIsSucceed() {
        let viewModel = RepositoryViewModel(client: MockGraphQLClient<SearchRepositoriesQuery>(response: mockedResponse))
        viewModel.getRepositories(phrase: "")
        XCTAssertEqual(viewModel.state, .success, "Request was not succeed")
    }
    
    func testGetRepositories_IfRepositoryIsEmpty() {
        qtdNodes = 0
        let viewModel = RepositoryViewModel(client: MockGraphQLClient<SearchRepositoriesQuery>(response: mockedResponse))
        viewModel.getRepositories(phrase: "")
        XCTAssertEqual(viewModel.state, .empty, "Request state should be empty")
    }
    
    func testGetRepositories_IfRepositoryWasLoaded() {
        let viewModel = RepositoryViewModel(client: MockGraphQLClient<SearchRepositoriesQuery>(response: mockedResponse))
        viewModel.getRepositories(phrase: "")
        XCTAssert(viewModel.repositories.count == qtdNodes, "Repositories was not loaded")
    }
}
