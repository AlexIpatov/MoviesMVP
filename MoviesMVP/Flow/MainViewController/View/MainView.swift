//
//  MainView.swift
//  MoviesMVP
//
//  Created by Александр Ипатов on 04.05.2021.
//

import UIKit

class MainView: UIView {
    // MARK: - Subviews
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.refreshControl = refreshControl
        addSubview(tableView)
        return tableView
    }()
    var refreshControl = UIRefreshControl(title: "Loading...")
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
