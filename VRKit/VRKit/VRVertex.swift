//
//  VRVertex.swift
//  VRKit
//
//  Created by François on 27/10/2015.
//  Copyright © 2015 XXII IO. All rights reserved.
//

import Foundation;

internal struct VRVertex
{
    /**
     *
     */
    internal var point: (Float, Float, Float);
    
    /**
     *
     */
    internal var color: (Float, Float, Float, Float);
    
    /**
     *
     */
    internal static let pointSlot: UnsafePointer<Int> = UnsafePointer<Int>(bitPattern: 0);
    
    /**
     *
     */
    internal static let colorSlot: UnsafePointer<Int> = UnsafePointer<Int>(bitPattern: 12);
    
    /**
     *
     */
    internal init(point: (Float, Float, Float), color: (Float, Float, Float, Float))
    {
        self.point = point;
        self.color = color;
    }
}
