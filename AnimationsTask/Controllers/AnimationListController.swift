//
//  ViewController.swift
//  AnimationsTask
//
//  Created by vitali on 11/6/18.
//  Copyright © 2018 vitcopr. All rights reserved.
//

import UIKit

class AnimationListController: UIViewController {

    
    //MARK: - Views
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: - Properties
    
    private var animationItems: [AnimationItem]!
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        animationItems = AnimationItem.all
    }
}


//MARK: - Private Helper methods
private extension AnimationListController {
    
    func configureTableView(){
        let nib1 = UINib(nibName: Consts.Cells.AnimationCell.xibName, bundle: Bundle.main)
        tableView.register(nib1, forCellReuseIdentifier: Consts.Cells.AnimationCell.reuseIdentifier)
        let nib2 = UINib(nibName: Consts.Cells.AnimItemWithSlider.xibName, bundle: Bundle.main)
        tableView.register(nib2, forCellReuseIdentifier: Consts.Cells.AnimItemWithSlider.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func animationItem(for indexPath: IndexPath) -> AnimationItem {
        return animationItems![indexPath.row]
    }
    
    
    func controllerFor(item: AnimationItem) -> UIViewController {
        switch item {
        case .fallAnimation:
            let storyboard = UIStoryboard(name: Consts.FallAnimationController.storyboardName, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: Consts.FallAnimationController.storyboardId)
        case .scaleAnimation(let scale):
            let storyboard = UIStoryboard(name: Consts.ScaleAnimationController.storyboardName, bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: Consts.ScaleAnimationController.storyboardId) as! ScaleAnimationController
            controller.scaleFactor = scale
            return controller
        case .unhookAnimation:
            let storyboard = UIStoryboard(name: Consts.UnhookAnimationController.storyboardName, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: Consts.UnhookAnimationController.storyboardId)
        }
    }
    
    func show(item: AnimationItem){
        let controller = controllerFor(item: item)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

//MARK: - UITableViewDelegate
extension AnimationListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = animationItem(for: indexPath)
        show(item: item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = animationItem(for: indexPath)
        switch item {
        case .fallAnimation, .unhookAnimation:
            return 44
        case .scaleAnimation(_):
            return 66
        }
    }
}

//MARK: - UITableViewDataSource
extension AnimationListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let animationItems = animationItems else {
            return 0
        }
        return animationItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = animationItem(for: indexPath)
        switch item {
        case .fallAnimation, .unhookAnimation:
            let cell = tableView.dequeueReusableCell(withIdentifier: Consts.Cells.AnimationCell.reuseIdentifier) as! AnimationCell
            return configureCell(cell, with: item)
        case .scaleAnimation(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: Consts.Cells.AnimItemWithSlider.reuseIdentifier) as! AnimItemWithSliderCell
            return configureCell(cell, with: item)
        }
    }
}


//MARK: - Cell configuration
extension AnimationListController {
    func configureCell(_ cell: AnimationCell, with item: AnimationItem) -> UITableViewCell {
        switch item {
        case .fallAnimation:
            cell.animationNameLabel.text = item.name
        case .unhookAnimation:
            cell.animationNameLabel.text = item.name
        default:
            fatalError("Wrong item type for cell")
        }
        return cell
    }
    
    func configureCell(_ cell: AnimItemWithSliderCell, with item: AnimationItem) -> UITableViewCell {
        switch item {
        case .scaleAnimation(let scale):
            cell.name.text = item.name
            cell.scaleFactorSlider.value = scale
            cell.scaleFactorLabel.text = String(scale)
            cell.delegate = self
        default:
            fatalError("Wrong item type for cell")
        }
        return cell
    }
}

//MARK: - ScaleAnimationDelegate
extension AnimationListController: ScaleAnimationDelegate {
    func setScale(_ scale: Float) {
        for i in 0..<animationItems.count {
            switch animationItems[i]{
            case .scaleAnimation(_):
                animationItems[i] = .scaleAnimation(scale)
            default:
                break
            }
        }
    }
}

