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
    
    
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
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
    
}

//MARK: - UITableViewDelegate
extension AnimationListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension AnimationListController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Consts.AnimationCell.reuseIdentifier) as! AnimationCell
        cell.animationNameLabel.text = "Test Name"
        return cell
    }
}
