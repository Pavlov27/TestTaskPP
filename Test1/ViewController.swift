//
//  ViewController.swift
//  Test1
//
//  Created by Nikita Pavlov on 06.08.2020.
//  Copyright © 2020 Nikita Pavlov. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController{

    var displayedNumbers = [Int]()
    var maxNumber = 100
    var getMoreNumbers = false
    var controlIsHidden = true
    var isSimpleNumbers = true
    var cellIsPair = true
    var cellIsUneven = true
    lazy var segmentedControl: UISegmentedControl = {
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
        displayedNumbers = ModelViewController.getSimpleNumbers(maxNumber: maxNumber)
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

    func viewSlideInFromTopToBottom(view: UIView) -> Void {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.layer.add(transition, forKey: kCATransition)
    }

    func viewSlideOutFromBottomToTop(view: UIView) -> Void {
        let transition:CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromTop
        view.layer.add(transition, forKey: kCATransition)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return displayedNumbers.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCell {

            if indexPath.row % 2 == 0 {
                if cellIsPair == true {
                    cell.backgroundColor = Colors.lightCellColor
                    cell.cellLabel.text = "\(displayedNumbers[indexPath.row])"
                    cellIsPair = false
                } else {
                    cell.backgroundColor = Colors.darkCellColor
                    cell.cellLabel.text = "\(displayedNumbers[indexPath.row])"
                    cellIsPair = true
                }
            } else {
                if cellIsUneven == true {
                    cell.cellLabel.text = "\(displayedNumbers[indexPath.row])"
                    cell.backgroundColor = Colors.darkCellColor
                    cellIsUneven = false
                } else {
                    cell.cellLabel.text = "\(displayedNumbers[indexPath.row])"
                    cell.backgroundColor = Colors.lightCellColor
                    cellIsUneven = true
                }
                
            }
            return cell
            } else {
                let emptycell = UICollectionViewCell()
                return emptycell
            }
        }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height  {
            if !getMoreNumbers {
                getMoreSimpleNumbers()
            }
        }
    }

    private func getMoreSimpleNumbers() {
        getMoreNumbers = true

        DispatchQueue.main.async {
            if self.isSimpleNumbers {
                self.maxNumber += 100
                self.displayedNumbers = ModelViewController.getSimpleNumbers(maxNumber:self.maxNumber)
            } else {
                self.maxNumber += 10
                self.displayedNumbers = ModelViewController.fibonacci(n:self.maxNumber)
            }
            self.getMoreNumbers = false
            self.cellIsPair = false
            self.cellIsUneven = false
            self.collectionView.reloadData()
        }
    }

    @objc func navBarTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        controlIsHidden = !controlIsHidden
        segmentedControl.isHidden = controlIsHidden
        if !controlIsHidden {
            self.viewSlideInFromTopToBottom(view: segmentedControl)
        } else {
            self.viewSlideOutFromBottomToTop(view: segmentedControl)
        }
    }

    @objc func segmentControl(_ segmentedControl: UISegmentedControl) {
       switch (segmentedControl.selectedSegmentIndex) {
          case 0:
            isSimpleNumbers = true
            maxNumber = 100
            navigationItem.title = "Простые числа∨"
            DispatchQueue.main.async {
                self.displayedNumbers = ModelViewController.getSimpleNumbers(maxNumber: self.maxNumber)
                self.collectionView.reloadData()
            }
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.centeredVertically, animated: false)
          case 1:
            isSimpleNumbers = false
            maxNumber = 20
            navigationItem.title = "Числа Фибоначчи∨"
            DispatchQueue.main.async {
                self.displayedNumbers = ModelViewController.fibonacci(n: self.maxNumber)
                self.collectionView.reloadData()
            }
            collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: UICollectionView.ScrollPosition.centeredVertically, animated: false)
          default:
          break
       }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: collectionView.frame.height/8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

