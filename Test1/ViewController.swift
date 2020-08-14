//
//  ViewController.swift
//  Test1
//
//  Created by Nikita Pavlov on 06.08.2020.
//  Copyright © 2020 Nikita Pavlov. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, UpdateDelegate {

    private var controlIsHidden = true
    private let dataSource = DataSource()
    private lazy var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Простые числа", "Числа Фибоначчи"])
        control.addTarget(self, action: #selector(segmentControl(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        control.isHidden = true
        return control
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavBar()
        setupCollectionView()
        setupSegmentedControl()
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource.delegate = self
    }

    private func setupNavBar(){

        navigationItem.title = "Простые числа∨"
        navigationController?.navigationBar.barTintColor = Colors.navBarColor
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]

        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(navBarTapped(tapGestureRecognizer:)))
        self.navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)
    }

    private func setupCollectionView(){
        collectionView?.backgroundColor = .white
        collectionView?.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
    }

    private func setupSegmentedControl(){
        view.addSubview(segmentedControl)
        segmentedControl.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        segmentedControl.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }

    func reloadData(sender: DataSource) {
        DispatchQueue.main.async {
                self.collectionView.reloadData()
        }
    }

    @objc func navBarTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        controlIsHidden = !controlIsHidden
        segmentedControl.isHidden = controlIsHidden
        if !controlIsHidden {
            Animation.viewSlideInFromTopToBottom(view: segmentedControl)
        } else {
            Animation.viewSlideOutFromBottomToTop(view: segmentedControl)
        }
    }

    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
            navigationItem.title = "Простые числа∨"
          case 1:
            navigationItem.title = "Числа Фибоначчи∨"
          default:
          break
       }
        DispatchQueue.main.async {
            ModelView.changeNumberType()
            self.collectionView.reloadData()
        }
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.centeredVertically, animated: false)
    }
}
