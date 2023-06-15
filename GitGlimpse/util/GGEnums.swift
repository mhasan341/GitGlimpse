//
//  GGEnums.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-14.
//

import UIKit

// used in repoDetailVC
enum StatInfoType{
    case starCount, forkCount, issueCount
}
// used in user profile view
enum ProfileInfoType {
    case follower, following
}

// for collectionView diffiable datasource we need this
enum Section {
    case main
}

// Custom error to replace the generic ones
enum GGError : String, Error{
    case invalidName = "The repo name is invalid"
    case invalidResponse = "Server returned invalid response"
}

// Quick access to assets
enum Images {
    static let headerImage = UIImage(systemName: "magnifyingglass")!
    static let placeholder = UIImage(named: "avatar-placeholder")!
    static let emptyState = UIImage(named: "empty-state")!
}

// from my GF repo
// helps on responsiveness and also help to create layouts for different devices based on their properties
enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
