//
//  PhotosSearchViewController.swift
// PhotoSearch
//
//  Created by Monali Rakhasiya on 05/03/2023.
//

import UIKit
import Combine

class PhotosSearchViewController : UIViewController {

    private var cancellables: [AnyCancellable] = []
    private let viewModel: PhotosSearchViewModelType
    private let selection = PassthroughSubject<PhotoViewModel, Never>()
    private let search = PassthroughSubject<String, Never>()
    private let appear = PassthroughSubject<Void, Never>()
    @IBOutlet private var loadingView: UIView!
    @IBOutlet private var tableView: UITableView!
    private lazy var alertViewController = AlertViewController(nibName: nil, bundle: nil)
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.tintColor = .label
        searchController.searchBar.delegate = self
        searchController.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifiers.PhotosSearch.searchTextFieldId
        return searchController
    }()
    private lazy var dataSource = makeDataSource()

    init(viewModel: PhotosSearchViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("Not supported!")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bind(to: viewModel)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appear.send(())
    }

    private func configureUI() {
        definesPresentationContext = true
        title = NSLocalizedString("Photos", comment: "Top Photos")
        view.accessibilityIdentifier = AccessibilityIdentifiers.PhotosSearch.rootViewId

        tableView.accessibilityIdentifier = AccessibilityIdentifiers.PhotosSearch.tableViewId
        tableView.tableFooterView = UIView()
        tableView.registerNib(cellClass: PhotoTableViewCell.self)
        tableView.dataSource = dataSource

        navigationItem.searchController = self.searchController
        searchController.isActive = true

        add(alertViewController)
        alertViewController.showStartSearch()
    }

    private func bind(to viewModel: PhotosSearchViewModelType) {
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        let input = PhotosSearchViewModelInput(appear: appear.eraseToAnyPublisher(),
                                               search: search.eraseToAnyPublisher(),
                                               selection: selection.eraseToAnyPublisher())

        let output = viewModel.transform(input: input)

        output.sink(receiveValue: {[unowned self] state in
            self.render(state)
        }).store(in: &cancellables)
    }

    private func render(_ state: PhotosSearchState) {
        switch state {
        case .idle:
            alertViewController.view.isHidden = false
            alertViewController.showStartSearch()
            loadingView.isHidden = true
            update(with: [], animate: true)
        case .loading:
            alertViewController.view.isHidden = true
            loadingView.isHidden = false
            update(with: [], animate: true)
        case .noResults:
            alertViewController.view.isHidden = false
            alertViewController.showNoResults()
            loadingView.isHidden = true
            update(with: [], animate: true)
        case .failure:
            alertViewController.view.isHidden = false
            alertViewController.showDataLoadingError()
            loadingView.isHidden = true
            update(with: [], animate: true)
        case .success(let movies):
            alertViewController.view.isHidden = true
            loadingView.isHidden = true
            update(with: movies, animate: true)
        }
    }
}

fileprivate extension PhotosSearchViewController {
    enum Section: CaseIterable {
        case movies
    }

    func makeDataSource() -> UITableViewDiffableDataSource<Section, PhotoViewModel> {
        return UITableViewDiffableDataSource(
            tableView: tableView,
            cellProvider: {  tableView, indexPath, PhotoViewModel in
                guard let cell = tableView.dequeueReusableCell(withClass: PhotoTableViewCell.self) else {
                    assertionFailure("Failed to dequeue \(PhotoTableViewCell.self)!")
                    return UITableViewCell()
                }
                cell.accessibilityIdentifier = "\(AccessibilityIdentifiers.PhotosSearch.cellId).\(indexPath.row)"
                cell.bind(to: PhotoViewModel)
                return cell
            }
        )
    }

    func update(with movies: [PhotoViewModel], animate: Bool = true) {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<Section, PhotoViewModel>()
            snapshot.appendSections(Section.allCases)
            snapshot.appendItems(movies, toSection: .movies)
            self.dataSource.apply(snapshot, animatingDifferences: animate)
        }
    }
}

extension PhotosSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search.send(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search.send("")
    }
}

extension PhotosSearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        selection.send(snapshot.itemIdentifiers[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
}
