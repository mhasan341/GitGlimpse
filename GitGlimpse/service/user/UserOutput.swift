//
//  UserOutput.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation
/// protocol for userInfoVC
protocol UserOutput: AnyObject{
    /// returns to delegated vc with GGUser object
    func updateUI(with userInfo: GGUser)
    /// returns to delegated vc with GGRepo array
    func updateUserRepo(with repos: [GGRepo])
}
