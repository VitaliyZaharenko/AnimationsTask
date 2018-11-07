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
    
    private var animationItems: [AnimationItem]?
    
    
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
        let nib = UINib(nibName: Consts.AnimationCell.xibName, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: Consts.AnimationCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    func animationItem(for indexPath: IndexPath) -> AnimationItem {
        return animationItems![indexPath.row]
    }
    
    func configureCell(_ cell: AnimationCell, with item: AnimationItem) -> UITableViewCell {
        switch item {
        case .fallAnimation:
            cell.animationNameLabel.text = item.name
            return cell
        }
    }
    
    func controllerFor(item: AnimationItem) -> UIViewController {
        switch item {
        case .fallAnimation:
            let storyboard = UIStoryboard(name: Consts.FallAnimationController.storyboardName, bundle: nil)
            return storyboard.instantiateViewController(withIdentifier: Consts.FallAnimationController.storyboardId)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Consts.AnimationCell.reuseIdentifier) as! AnimationCell
        let item = animationItem(for: indexPath)
        return configureCell(cell, with: item)
    }
}
