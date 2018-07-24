//
//  HomeViewController.swift
//  ProficiencyExercise
//
//  Created by Ajay Parmar on 7/23/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController, HomeViewControllerDelegate {

    //Table
    private var homeTableView: UITableView!
    
    //View model
    let viewModel = HomeModel()
    
    //Create properties and variables
    var navBarTitleText = ""
    var navBar: UINavigationBar = UINavigationBar()
    var navItem = UINavigationItem()
    var refreshDataControl = UIRefreshControl()
    var activityView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.applyDefaultStyle()
        self.bindViewMode()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.makeAPICall()
    }
    
    func applyDefaultStyle(){
        //Default style
        
        // Top bar
        let topBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // Navigation bar
         navBar = UINavigationBar(frame: CGRect(x: 0, y: topBarHeight, width: self.view.frame.width, height: ViewNumberConstants.kNavigationBarHeight))
        navItem = UINavigationItem(title: navBarTitleText);
        navBar.setItems([navItem], animated: false);
        self.view.addSubview(navBar);
        
        let tableViewWidth: CGFloat = self.view.frame.width
        let tableViewHeight: CGFloat = self.view.frame.height
        
        //Table frame (as content view)
        homeTableView = UITableView(frame: CGRect(x: 0, y: (ViewNumberConstants.kNavigationBarHeight), width: tableViewWidth, height: tableViewHeight - (ViewNumberConstants.kNavigationBarHeight)))
        
        //Register table view cell
        let nib1 = UINib(nibName: HomeTableViewCellName, bundle: nil)
        homeTableView.register(nib1, forCellReuseIdentifier: HomeTableViewCellIdentifier)
        
        //Add table view with main view
        self.view.addSubview(homeTableView)
        
        //Pull to refresh
        refreshDataControl.attributedTitle = NSAttributedString(string: "Refreshing")
        refreshDataControl.addTarget(self, action: #selector(refreshTableData), for: .valueChanged)
        homeTableView.addSubview(refreshDataControl)
        
        //Indicator
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
    }

    func bindViewMode(){
        viewModel.tableView = homeTableView
        viewModel.delegate = self
        
        //Setup the datasource delegate
        homeTableView.delegate = viewModel
        homeTableView.dataSource = viewModel
    }
    
    func setNavBarTitle(title: String){
        navBarTitleText = title
        navItem = UINavigationItem(title: navBarTitleText);
        DispatchQueue.main.async {
            self.navBar.setItems([self.navItem], animated: false);
        }
    }
    
    @objc func refreshTableData(sender:AnyObject) {
        // Code to refresh table view
        viewModel.makeAPICall()
        refreshDataControl.endRefreshing()
    }
    
    func showIndicator(){
        activityView.startAnimating()
    }
    
    func hideActivityIndicator(){
        activityView.stopAnimating()
    }
}


