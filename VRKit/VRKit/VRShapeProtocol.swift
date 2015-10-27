//
//  VRShapeProtocol.swift
//  VRKit
//
//  Created by François on 27/10/2015.
//  Copyright © 2015 XXII IO. All rights reserved.
//

import Foundation;

internal protocol VRShapeProtocol
{
    /**
     *
     */
    var vertices: [VRVertex] { get }
    
    /**
     *
     */
    var indices: [GLubyte] { get };
}