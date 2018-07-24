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
        
        // Top bar
        let topBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Navigation bar
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.width, height: ViewNumberConstants.kNavigationBarHeightIphone))
        self.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "temp title");
        navBar.setItems([navItem], animated: false);
        
        let tableViewWidth: CGFloat = self.view.frame.width
        let tableViewHeight: CGFloat = self.view.frame.height
        
        //Table frame (as content view)
        homeTableView = UITableView(frame: CGRect(x: 0, y: (ViewNumberConstants.kNavigationBarHeightIphone), width: tableViewWidth, height: tableViewHeight - (ViewNumberConstants.kNavigationBarHeightIphone)))
        
        //Register table view cell
        let nib1 = UINib(nibName: HomeTableViewCellName, bundle: nil)
        homeTableView.register(nib1, forCellReuseIdentifier: HomeTableViewCellIdentifier)
        
        //Add table view with main view
        self.view.addSubview(homeTableView)
    }

    func bindViewMode(){
        viewModel.tableView = homeTableView
        
        //Setup the datasource delegate
        homeTableView.delegate = viewModel
        homeTableView.dataSource = viewModel
        
        viewModel.makeAPICall()
    }
    
}


