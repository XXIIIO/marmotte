//
//  VRPlayerViewController.swift
//  VRKit
//
//  Created by François on 27/10/2015.
//  Copyright © 2015 XXII IO. All rights reserved.
//

import Foundation;
import GLKit;

public class VRPlayerViewController: GLKViewController
{
    /**
     *
     */
    private var vertices: [GLfloat] = [
       -0.5,   -0.5,
        0.0,    0.5,
        0.5,   -0.5
    ];
    
    /**
     *
     */
    private var programId: GLuint = GLuint();
    
    /**
     *
     */
    public override func loadView()
    {
        print("VRPlayerViewController -> loadView");
        // let view = GLKView(frame: CGRectMake(0, 0, 100, 100), context: EAGLContext())
        let view: GLKView = GLKView();
        
        // Setup context
        view.context = EAGLContext(API: EAGLRenderingAPI.OpenGLES2);
        
        if(!EAGLContext.setCurrentContext(view.context))
        {
            print("Failed to set current OpenGL context!");
            exit(1);
        }
        
        view.drawableDepthFormat = GLKViewDrawableDepthFormat.Format24;
        self.preferredFramesPerSecond = 30;
        
        self.view = view;
    }
    
    /**
     *
     */
	public override func viewDidLoad()
    {
        print("VRPlayerViewController -> viewDidLoad");
		super.viewDidLoad();
        
        /*
        // Compile our vertex and fragment shaders.
        let vertexShader: GLuint = self.dynamicType.compileShader("Simple", shaderType: GLenum(GL_VERTEX_SHADER));
        let fragmentShader: GLuint = self.dynamicType.compileShader("Simple", shaderType: GLenum(GL_FRAGMENT_SHADER));
        
        // Call glCreateProgram, glAttachShader, and glLinkProgram to link the vertex and fragment shaders into a complete program.
        self.programId = glCreateProgram();
        glAttachShader(self.programId, vertexShader);
        glAttachShader(self.programId, fragmentShader);
        glLinkProgram(self.programId);

        // Check for any errors
        var linkSuccess: GLint = GLint();
        glGetProgramiv(self.programId, GLenum(GL_LINK_STATUS), &linkSuccess);
        
        if(linkSuccess == GL_FALSE)
        {
            print("Failed to create shader program!");
            // TODO: Actually output the error that we can get from the glGetProgramInfoLog function.
            exit(1);
        }
        
        // Call glUseProgram to tell OpenGL to actually use this program when given vertex info
        glUseProgram(self.programId);
        */
	}
    
    /**
     *
     */
    public override func viewDidAppear(animated: Bool)
    {
        print("VRPlayerViewController -> viewDidAppear");
        super.viewDidAppear(animated);
    }
    
    /**
     *
     */
    public override func glkView(view: GLKView, drawInRect rect: CGRect)
    {
        let blue: GLfloat = GLfloat(NSDate().timeIntervalSince1970%10) / 5;
        print("VRPlayerViewController -> glkView drawInRect \(self.programId) - \(blue)");
        
        glClearColor(1, 1, blue, 1.0);
        glClear(GLbitfield(GL_COLOR_BUFFER_BIT));
        
        view.context.presentRenderbuffer(Int(GL_RENDERBUFFER));
    }
    
    /**
     *
     */
    private static func compileShader(shaderName: String, shaderType: GLenum) -> GLuint
    {
        let shaderExt: String;
        
        switch(shaderType)
        {
            case GLenum(GL_VERTEX_SHADER): shaderExt = "vsh"; break;
            case GLenum(GL_FRAGMENT_SHADER): shaderExt = "fsh"; break;
            default: return 0;
        }
        
        // Get NSString with contents of our shader file.
        let shaderPath: String! = NSBundle.VRKitBundle().pathForResource(shaderName, ofType: shaderExt);
        print("\(shaderPath)");
        
        var shaderString: NSString?;
        
        do
        {
            shaderString = try NSString(contentsOfFile:shaderPath, encoding: NSUTF8StringEncoding);
        }
        catch let error as NSError
        {
            print("\(error.localizedDescription)");
            shaderString = nil;
        }
        
        if (shaderString == nil)
        {
            print("Failed to set contents shader of shader file!");
        }
        
        // Tell OpenGL to create an OpenGL object to represent the shader, indicating if it's a vertex or a fragment shader.
        let shaderHandle: GLuint = glCreateShader(shaderType);
        
        if shaderHandle == 0
        {
            NSLog("Couldn't create shader");
        }
        
        // Conver shader string to CString and call glShaderSource to give OpenGL the source for the shader.
        var shaderStringUTF8 = shaderString!.UTF8String;
        var shaderStringLength: GLint = GLint(Int32(shaderString!.length));
        glShaderSource(shaderHandle, 1, &shaderStringUTF8, &shaderStringLength);
        
        // Tell OpenGL to compile the shader.
        glCompileShader(shaderHandle);
        
        // But compiling can fail! If we have errors in our GLSL code, we can here and output any errors.
        var compileSuccess: GLint = GLint();
        glGetShaderiv(shaderHandle, GLenum(GL_COMPILE_STATUS), &compileSuccess);
        
        if (compileSuccess == GL_FALSE)
        {
            print("Failed to compile shader!");
            // TODO: Actually output the error that we can get from the glGetShaderInfoLog function.
            exit(1);
        }
        
        return shaderHandle;
    }
}