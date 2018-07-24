//
//  HomeModel.swift
//  ProficiencyExercise
//
//  Created by Ajay Parmar on 7/23/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import UIKit

//Custom delegate for update title
@objc protocol HomeViewControllerDelegate{
    
    func setNavBarTitle(title: String)
    func showIndicator()
    func hideActivityIndicator()
}

class HomeModel: NSObject {

     //Table
     var tableView : UITableView?
    
    //Create properties and variables
     var tableRowsDataArr : NSArray = []
     weak var delegate: HomeViewControllerDelegate?
     
}

extension HomeModel: UITableViewDataSource,UITableViewDelegate{
    
    // Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableRowsDataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCellIdentifier, for: indexPath) as! HomeTableViewCell
        cell.selectionStyle = .none
        let tableDataDictionary = self.tableRowsDataArr[indexPath.row] as! NSDictionary
        if let title = tableDataDictionary[kTitle] as? String {
            cell.titleText.text = title
        }else{
            cell.titleText.text = ""
        }
        if let description = tableDataDictionary[kDescription] as? String {
            cell.descriptionText.text = description
        }else{
            cell.descriptionText.text = ""
        }
        if let imageHref = tableDataDictionary[kImageURL] as? String {
            cell.homeTableImage.downloadImage(link: imageHref)
        }else{
            //Need placeholder to set here
            cell.homeTableImage.downloadImage(link: "")
            
        }
        
        return cell
    }
}

//Server API call
extension HomeModel{
    func makeAPICall() {
        delegate?.showIndicator()
        let url = URL(string: baseURL)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error as Any)
            } else {
                let responseStrInISOLatin = String(data: data!, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    return
                }
                do {
                    let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                    //Parse JSON data
                    let mainResponseDict = responseJSONDict as! NSDictionary
                    let navBarTitle = mainResponseDict[kTitle] as! String
                    self.delegate?.setNavBarTitle(title: navBarTitle)
                    self.tableRowsDataArr = mainResponseDict[kRows] as! NSArray
                    DispatchQueue.main.async {
                        self.delegate?.hideActivityIndicator()
                        self.tableView?.reloadData()
                    }
                    
                } catch {
                    print(error)
                }
            }

            }.resume()
    }
    
}

// Download image from URL
extension UIImageView {
    func downloadImage(url: URL, fromMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix(kImagePrefix),
                let data = data, error == nil,
                let imageData = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = imageData
            }
            }.resume()
    }
    func downloadImage(link: String, fromMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadImage(url: url, fromMode: mode)
    }
}

