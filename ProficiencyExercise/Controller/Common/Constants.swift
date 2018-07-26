//
//  Constants.swift
//  ProficiencyExercise
//
//  Created by Ajay Parmar on 7/24/18.
//  Copyright © 2018 Ajay Parmar. All rights reserved.
//

import UIKit
import Foundation

    // Base URL's
    let baseURL  = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

    // Server Constants
    let kTitle = "title"
    let kDescription = "description"
    let kImageURL = "imageHref"
    let kRows = "rows"

    // TableView Cell
    let HomeTableViewCellName = "HomeTableViewCell"


    // TableView Cell Identifiers
    let HomeTableViewCellIdentifier = "HomeTableCell"

    // String Constants
    let kImagePrefix = "image"
    let kAppName = "ProficiencyExercise"
    let kAlertTitle = "Oops!"
    let kNetworkError = "There seems to be problem with your internet.\nPlease check your internet connection to proceed."
    let kConnectionError = "Network error with status:"
    let kRetryButton = "RETRY"
    let kRefreshing = "Refreshing"

    // Number constants
    struct ViewNumberConstants {
        static let kNavigationBarHeight = CGFloat(64)
    }

    //Test Cases
    let kPost = "POST"
    let kDataNotNill = "data should not be nil"
    let kErrorNill = "error should be nil"
    let kResponseURLString = "HTTP response URL should be equal to original URL"
    let kResponseStatusString = "HTTP response status code should be 200"
    let kFailResponseMessage = "Response was not NSHTTPURLResponse"
    let kFailureURL = "https://dl.dropboxusercontent.com/testfail"
    let kDataNill = "data should be nil"
    let kErrorNotNill = "error should not be nil"
    let kFailResponseMessageFail = "Response was NSHTTPURLResponse"

    // Network
    let kSuccessCode = 200
    let kFileNotFound = 404


