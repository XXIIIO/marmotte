//
//  Simple.vsh
//  VRKit
//
//  Created by Fanch on 16/10/2015.
//  Copyright 2015 AppsGo. All rights reserved.
//

attribute vec4 Position;
attribute vec4 SourceColor;
 
varying vec4 DestinationColor;
 
void main(void)
{
    DestinationColor = SourceColor;
    gl_Position = Position;
}