//
//  RepoOutput.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation
/// protocol for repositoryDetailsVC
protocol RepoOutput: AnyObject{
    func updateUI(with repos: [GGRepo])
}
