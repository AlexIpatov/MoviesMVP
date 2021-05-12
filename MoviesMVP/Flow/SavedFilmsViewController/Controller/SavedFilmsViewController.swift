//
//  SavedFilmsViewController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import UIKit

class SavedFilmsViewController: UIViewController {

    var recommendedFilms = [Film]() {
        didSet {
            reloadData()
        }
    }
    var savedFilms = [Film]() {
        didSet {
            reloadData()
        }
    }
    private let presenter: SavedFilmsViewOutput

    private lazy var savedFilmsView: SavedFilmsView = {
        SavedFilmsView()
    }()

    // MARK: - Init
    init(presenter: SavedFilmsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    override func loadView() {
        self.view = savedFilmsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        createDataSource()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        requestDataForCollectionView()
    }

    private func requestDataForCollectionView() {
        presenter.viewDidRequest()
        presenter.viewDidRequestSavedFilms()
    }
    // MARK: - CollectionView set up
    var dataSource: UICollectionViewDiffableDataSource<Section, Film>?

    private func setupCollectionView() {
        savedFilmsView.collectionView.register(RecommendedFilmCell.self,
                                         forCellWithReuseIdentifier: RecommendedFilmCell.reuseId)
        savedFilmsView.collectionView.register(SavedFilmCell.self,
                                         forCellWithReuseIdentifier: SavedFilmCell.reuseId)
        savedFilmsView.collectionView.register(SectionHeader.self,
                                         forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: SectionHeader.reuseId)
        savedFilmsView.collectionView.delegate = self
    }
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Film>()
        snapshot.appendSections([.recommended, .myFilms])
        snapshot.appendItems(recommendedFilms, toSection: .recommended)
        snapshot.appendItems(savedFilms, toSection: .myFilms)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
// MARK: - Data Source
extension SavedFilmsViewController {
    private func createDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Film>(collectionView: savedFilmsView.collectionView,
                                                                              cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
                                                                                guard let section = Section(rawValue: indexPath.section) else {
                                                                                    fatalError("Unknown section kind")
                                                                                }
                                                                                switch section {
                                                                                case .recommended:
                                                                                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendedFilmCell.reuseId,
                                                                                                                                        for: indexPath) as? RecommendedFilmCell else { return UICollectionViewCell() }
                                                                                    cell.configure(with: item)
                                                                                    return cell
                                                                                case .myFilms:
                                                                                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SavedFilmCell.reuseId,
                                                                                                                                        for: indexPath) as? SavedFilmCell else { return UICollectionViewCell() }
                                                                                    cell.configure(with: item)
                                                                                    return cell

                                                                                }
                                                                              })
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                      withReuseIdentifier: SectionHeader.reuseId,
                                                                                      for: indexPath) as? SectionHeader else {
                fatalError("Can not create new section header")
            }
            guard let section = Section(rawValue: indexPath.section) else { fatalError("Unknown section kind") }
            sectionHeader.configure(text: section.description(),
                                    font: .filmTitleFont(),
                                    textColor: .gray)
            return sectionHeader
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SavedFilmsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension SavedFilmsViewController: SavedFilmsViewInput {
    func showError() {
        print("error")
    }

}
