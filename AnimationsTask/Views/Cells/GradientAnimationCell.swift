//
//  GradientAnimationCell.swift
//  AnimationsTask
//
//  Created by vitali on 11/20/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class GradientAnimationCell: UITableViewCell {
    
    //MARK: - Views
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties
    
    private var colors: [UIColor] = [UIColor.blue, UIColor.green, UIColor.yellow]

    
    //MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCollectionView()
    }
    
    
}

//MARK: - Private helper methods

private extension GradientAnimationCell {
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        let colorCellNib = UINib(nibName: Consts.CollectionViewCells.Color.xibName, bundle: Bundle.main)
        collectionView.register(colorCellNib, forCellWithReuseIdentifier: Consts.CollectionViewCells.Color.reuseIdentifier)
        let addColorCellNib = UINib(nibName: Consts.CollectionViewCells.AddColor.xibName, bundle: Bundle.main)
        collectionView.register(addColorCellNib, forCellWithReuseIdentifier: Consts.CollectionViewCells.AddColor.reuseIdentifier)
    }
    
    func colorFor(indexPath: IndexPath) -> UIColor {
        return colors[indexPath.row]
    }
    
    func addColorClicked(){
        colors.append(UIColor.orange)
        collectionView.reloadData()
    }
}


//MARK: - UICollectionViewDelegate

extension GradientAnimationCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == colors.count){
            addColorClicked()
        } else {
            colors.remove(at: indexPath.row)
            collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDataSource

extension GradientAnimationCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == colors.count){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Consts.CollectionViewCells.AddColor.reuseIdentifier, for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Consts.CollectionViewCells.Color.reuseIdentifier, for: indexPath) as! ColorCollectionViewCell
            let color = colorFor(indexPath: indexPath)
            cell.colorView.backgroundColor = color
            return cell
        }
        
    }
}
