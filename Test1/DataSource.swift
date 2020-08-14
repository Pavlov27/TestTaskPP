//
//  DataSource.swift
//  Test1
//
//  Created by Nikita Pavlov on 14.08.2020.
//  Copyright © 2020 Nikita Pavlov. All rights reserved.
//

import UIKit

protocol UpdateDelegate {
    func reloadData(sender: DataSource)
}

class DataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    private var getMoreNumbers = false
    var delegate: UpdateDelegate?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ModelView.displayedNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCell {

        cell.cellLabel.text = "\(ModelView.displayedNumbers[indexPath.row])"
        return cell
        } else {
            let emptycell = UICollectionViewCell()
            return emptycell
        }
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? CustomCell else { return }

        let squareIndex = indexPath.item % 4
        if (squareIndex == 0 || squareIndex == 3) {
            cell.backgroundColor = Colors.lightCellColor
        } else {
            cell.backgroundColor = Colors.darkCellColor
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.height {
            if !getMoreNumbers {
                ModelView.getMoreNumbers()
                self.delegate?.reloadData(sender: self)
                getMoreNumbers = false
             }
        }
    }
    
}

extension DataSource: UICollectionViewDelegateFlowLayout {
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

