//
//  SavedFilmsViewController.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 08.05.2021.
//

import UIKit

class SavedFilmsViewController: UIViewController, SavedFilmsViewInput {
    // MARK: - Properties
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
        setupNavigationItems()
        setupCollectionView()
        createDataSource()
        presenter.viewDidRequest()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        requestDataForCollectionView()
    }
    // MARK: - Setup navigation items
    private func setupNavigationItems() {
        navigationItem.title = "Saved films"
    }
    private func requestDataForCollectionView() {
        presenter.viewDidRequestSavedFilms()
    }
    // MARK: - CollectionView set up
    var dataSource: UICollectionViewDiffableDataSource<Section, Film>?
    private func setupCollectionView() {
        savedFilmsView.collectionView.register(SavedFilmCell.self,
                                               forCellWithReuseIdentifier: SavedFilmCell.reuseId)
        savedFilmsView.collectionView.register(SectionHeader.self,
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                               withReuseIdentifier: SectionHeader.reuseId)
        savedFilmsView.collectionView.register(SectionFooter.self,
                                               forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                               withReuseIdentifier: SectionFooter.reuseId)
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
        dataSource = UICollectionViewDiffableDataSource
        <Section, Film>(collectionView: savedFilmsView.collectionView,
                        cellProvider: {(collectionView, indexPath, item) -> UICollectionViewCell? in
                            guard let section = Section(rawValue: indexPath.section) else {
                                fatalError("Unknown section kind")
                            }
                            switch section {
                            case .recommended:
                                return self.configure(collectionView: collectionView,
                                                      cellType: SavedFilmCell.self,
                                                      with: item,
                                                      for: indexPath)
                            case .myFilms:
                                return self.configure(collectionView: collectionView,
                                                      cellType: SavedFilmCell.self,
                                                      with: item,
                                                      for: indexPath)
                            }
                        })
        dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionFooter {
                guard let sectionFooter = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                                                                          withReuseIdentifier: SectionFooter.reuseId,
                                                                                          for: indexPath) as? SectionFooter else {
                    fatalError("Can not create new section header")
                }
                sectionFooter.deleteAllButton.addTarget(self,
                                                        action: #selector(self.deleteAllButtonTapped),
                                                        for: .touchUpInside)
                return sectionFooter
            }
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
        guard let currentCell = self.dataSource?.itemIdentifier(for: indexPath) else { return }
        presenter.viewDidSelectFilm(currentCell)
    }
}
// MARK: Actions
extension SavedFilmsViewController {
    @objc private func deleteAllButtonTapped() {
        presenter.viewDidRequestDeleteAllFilms()
        requestDataForCollectionView()
    }
}
