//
//  CommitOutput.swift
//  GitGlimpse
//
//  Created by Mahmudul Hasan on 2023-06-15.
//

import Foundation
/// protocol for commitListVC
protocol CommitOutput: AnyObject {
    func updateUI(with commits: [CommitHistory])
}
