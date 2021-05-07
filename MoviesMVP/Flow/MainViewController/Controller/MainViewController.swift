//
//  MainViewController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: View
    private lazy var mainView: MainView = {
        MainView()
    }()
    // MARK: Results from api
     var results = [Film]() {
        didSet {
            mainView.tableView.reloadData()
        }
    }
    private let presenter: MainViewOutput
        // MARK: - Init
        init(presenter: MainViewOutput) {
            self.presenter = presenter
            super.init(nibName: nil, bundle: nil)
        }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func loadView() {
        self.view = mainView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        fetchData()
        addTargets()
    }
    // MARK: - FetchData
    private func fetchData() {
        presenter.viewDidRequest()
    }
    // MARK: - Setup TableView
    private func setupTableView() {
        mainView.tableView.register(MainVCFilmCell.self,
                                    forCellReuseIdentifier: MainVCFilmCell.reuseId)
        mainView.tableView.delegate = self
        mainView.tableView.prefetchDataSource = self
        mainView.tableView.dataSource = self
    }
}
// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainVCFilmCell.reuseId,
                                                       for: indexPath) as? MainVCFilmCell else {return UITableViewCell()}
        let film = results[indexPath.row]
        cell.configure(with: film)
        return cell
    }
}
// MARK: - UITableViewDataSourcePrefetching
extension MainViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard indexPaths.contains(where: isloadingCell(for:)) else {
            return
        }
        presenter.viewDidRequestMoreFilms()
    }
    func isloadingCell(for indexPath: IndexPath) -> Bool {
        let filmsCount = results.count
        return indexPath.row == filmsCount - 3
    }
}
// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentFilm = results[indexPath.row]
        presenter.viewDidSelectFilm(currentFilm)
    }
}
// MARK: - Actions
extension MainViewController {
    func addTargets() {
        mainView.refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    @objc func refreshData() {
        mainView.refreshControl.beginRefreshing()
        fetchData()
        mainView.refreshControl.endRefreshing()
    }
}
// MARK: - MainViewInput
extension MainViewController: MainViewInput {
    func showError() {
        print("error")
    }
}
