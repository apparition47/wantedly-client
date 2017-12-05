//
//  ProjectsGateway.swift
//  Wclient
//
//  Created by Aaron Lee on 2017/12/04.
//  Copyright © 2017 Aaron Lee. All rights reserved.
//

import Foundation

typealias SearchProjectsEntityGatewayCompletionHandler = (_ projects: Result<[Project]>) -> Void

protocol ProjectsGateway {
    func search(parameters: SearchProjectsParameters, completionHandler: @escaping SearchProjectsEntityGatewayCompletionHandler)
}
