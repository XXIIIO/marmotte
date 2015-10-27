//
//  NSBundle.swift
//  VRKit
//
//  Created by François on 27/10/2015.
//  Copyright © 2015 XXII IO. All rights reserved.
//

import Foundation;

internal extension NSBundle
{
    /**
     * Shortcut to framework bundle.
     */
    internal static func VRKitBundle() -> NSBundle
    {
        return NSBundle(identifier: "io.xxii.VRKit")!;
    }
    
    /**
     * Shortcut to CFBundleName.
     */
    internal var bundleName: String
    {
        return self.infoDictionary!["CFBundleName"] as! String;
    }
}