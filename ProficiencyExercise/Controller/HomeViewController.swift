//
//  HomeViewController.swift
//  ProficiencyExercise
//
//  Created by Ajay Parmar on 7/23/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //Table
    private var homeTableView: UITableView!
    
    //View model
    let viewModel = HomeModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyDefaultStyle()
        self.bindViewMode()
    }
    
    func applyDefaultStyle(){
        
        //Default style
        let topBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let tableViewWidth: CGFloat = self.view.frame.width
        let tableViewHeight: CGFloat = self.view.frame.height
        
        //Table frame (as content view)
        homeTableView = UITableView(frame: CGRect(x: 0, y: topBarHeight, width: tableViewWidth, height: tableViewHeight - topBarHeight))
        
        //Register table view cell
        let nib1 = UINib(nibName: "HomeTableViewCell", bundle: nil)
        homeTableView.register(nib1, forCellReuseIdentifier: "HomeTableCell")
        
        //Main view
        self.view.addSubview(homeTableView)
    }

    func bindViewMode(){
        viewModel.tableView = homeTableView
        
        //Setup the datasource delegate
        homeTableView.delegate = viewModel
        homeTableView.dataSource = viewModel
    }
    
}
