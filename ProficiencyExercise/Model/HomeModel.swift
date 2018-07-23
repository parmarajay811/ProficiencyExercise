//
//  HomeModel.swift
//  ProficiencyExercise
//
//  Created by Ajay Parmar on 7/23/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import UIKit

class HomeModel: NSObject {

     //Table
     var tableView : UITableView?
     //Hard coaded until not getting data from server
    private let tblArray: NSArray = ["Wipro1","Wipro2","Wipro3"]
}

extension HomeModel: UITableViewDataSource,UITableViewDelegate{
    
    // Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tblArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableViewCell
        cell.titleText.text = "\(tblArray[indexPath.row])"
        return cell
    }
}
