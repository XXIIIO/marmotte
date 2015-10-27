//
//  VRSpereProtocol.swift
//  VRKit
//
//  Created by François on 27/10/2015.
//  Copyright © 2015 XXII IO. All rights reserved.
//

import Foundation;

internal struct VRSphereShape: VRShapeProtocol
{
    /**
     *
     */
    internal let depth: Int;
    
    /**
     *
     */
    internal let vertices: [VRVertex];
    
    /**
     *
     */
    internal let indices: [GLubyte];
    
    /**
     *
     */
    internal init(depth: Int)
    {
        self.depth = depth;
        
        self.vertices =
        [
            // Background Top Right
            VRVertex(point: ( 1,  0,  0), color: (1, 1, 1, 1)),
            VRVertex(point: ( 0,  1,  0), color: (1, 1, 1, 1)),
            VRVertex(point: ( 0,  0, -1), color: (1, 0, 0, 1)),
            
            // Background Top Left
            VRVertex(point: ( 0,  1,  0), color: (0, 0, 0, 1)),
            VRVertex(point: (-1,  0,  0), color: (0, 0, 0, 1)),
            VRVertex(point: ( 0,  0, -1), color: (1, 0, 0, 1)),
            
            // Background Bottom Right
            VRVertex(point: (-1,  0,  0), color: (1, 1, 1, 1)),
            VRVertex(point: ( 0, -1,  0), color: (1, 1, 1, 1)),
            VRVertex(point: ( 0,  0, -1), color: (1, 0, 0, 1)),
            
            // Background Bottom Left
            VRVertex(point: ( 0, -1,  0), color: (0, 0, 0, 1)),
            VRVertex(point: ( 1,  0,  0), color: (0, 0, 0, 1)),
            VRVertex(point: ( 0,  0, -1), color: (1, 0, 0, 1)),
            
            // Foreground Top Right
            VRVertex(point: ( 1,  0,  0), color: (0, 0, 0, 1)),
            VRVertex(point: ( 0,  1,  0), color: (0, 0, 0, 1)),
            VRVertex(point: ( 0,  0,  1), color: (0, 0, 1, 1)),
            
            // Foreground Top Left
            VRVertex(point: ( 0,  1,  0), color: (1, 1, 1, 1)),
            VRVertex(point: (-1,  0,  0), color: (1, 1, 1, 1)),
            VRVertex(point: ( 0,  0,  1), color: (0, 0, 1, 1)),
            
            // Foreground Bottom Right
            VRVertex(point: (-1,  0,  0), color: (0, 0, 0, 0)),
            VRVertex(point: ( 0, -1,  0), color: (0, 0, 0, 0)),
            VRVertex(point: ( 0,  0,  1), color: (0, 0, 1, 1)),
            
            // Foreground Bottom Left
            VRVertex(point: ( 0, -1,  0), color: (1, 1, 1, 1)),
            VRVertex(point: ( 1,  0,  0), color: (1, 1, 1, 1)),
            VRVertex(point: ( 0,  0,  1), color: (0, 0 ,1, 1))
        ];
        
        self.indices =
        [
            // Background
            00, 01, 02,
            03, 04, 05,
            06, 07, 08,
            09, 10, 11,
            
            // Foreground
            13, 12, 14,
            16, 15, 17,
            19, 18, 20,
            22, 21, 23
        ];
    }
}