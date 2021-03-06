//
//  VRDevViewController.swift
//  VRKit
//
//  Created by François on 27/10/2015.
//  Copyright © 2015 XXII IO. All rights reserved.
//

import Foundation;
import GLKit;
import CoreMotion;

public class VRDevViewController: GLKViewController
{
    private var vertexBuffer: GLuint = GLuint();
    private var indexBuffer: GLuint = GLuint();
    private var vertexArray: GLuint = GLuint();
    
    private var rotationX: CGFloat = 0;
    private var rotationY: CGFloat = 0;

    private var effect: GLKBaseEffect!;
    private let sphere: VRShapeProtocol;
    
    private let motionManager: CMMotionManager;
    private var referenceAttitude: CMAttitude?;
    
    /**
     *
     */
    public init()
    {
        self.sphere = VROctahedronShape();
        
        self.motionManager = CMMotionManager()
        self.motionManager.startDeviceMotionUpdates();
        
        super.init(nibName: nil, bundle: nil);
    }

    public required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented");
    }
    
    public override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask
    {
        // return UIInterfaceOrientationMask.Landscape;
        return UIInterfaceOrientationMask.Portrait;
        // return UIInterfaceOrientationMask.AllButUpsideDown;
    }
    
    public override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator)
    {
        print("VRDevViewController -> viewWillTransitionToSize");
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator);
    }
    
    public override func prefersStatusBarHidden() -> Bool
    {
        return false;
    }
    
    /**
     *
     */
    public override func viewDidLoad()
    {
        super.viewDidLoad();
        print("VRDevViewController -> viewDidLoad");
        
        let view: GLKView = self.view as! GLKView;
        view.context = EAGLContext(API: EAGLRenderingAPI.OpenGLES2);
        view.drawableMultisample = GLKViewDrawableMultisample.Multisample4X;
        
        self.setup();
        
        let panGestureRecognizer: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panOnView:");
        panGestureRecognizer.minimumNumberOfTouches = 1;
        panGestureRecognizer.maximumNumberOfTouches = 1;
        view.addGestureRecognizer(panGestureRecognizer);
    }
    
    /**
     *
     */
    public func setup()
    {
        print("VRDevViewController -> setup");
        
        let view: GLKView = self.view as! GLKView;
        EAGLContext.setCurrentContext(view.context)
        
        glEnable(GLenum(GL_CULL_FACE));
        
        self.effect = GLKBaseEffect();
        
        glGenVertexArraysOES(1, &self.vertexArray);
        glBindVertexArrayOES(self.vertexArray);
        
        glGenBuffers(1, &self.vertexBuffer);
        glBindBuffer(GLenum(GL_ARRAY_BUFFER), self.vertexBuffer);
        glBufferData(GLenum(GL_ARRAY_BUFFER), self.sphere.vertices.count * sizeof(VRVertex), self.sphere.vertices, GLenum(GL_STATIC_DRAW));
        
        glGenBuffers(1, &self.indexBuffer);
        glBindBuffer(GLenum(GL_ELEMENT_ARRAY_BUFFER), self.indexBuffer);
        glBufferData(GLenum(GL_ELEMENT_ARRAY_BUFFER), self.sphere.indices.count * sizeof(GLubyte), self.sphere.indices, GLenum(GL_STATIC_DRAW));
        
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.Position.rawValue));
        glVertexAttribPointer(GLuint(GLKVertexAttrib.Position.rawValue), 3, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(sizeof(VRVertex)), VRVertex.pointSlot);
        
        glEnableVertexAttribArray(GLuint(GLKVertexAttrib.Color.rawValue));
        glVertexAttribPointer(GLuint(GLKVertexAttrib.Color.rawValue), 4, GLenum(GL_FLOAT), GLboolean(GL_FALSE), GLsizei(sizeof(VRVertex)), VRVertex.colorSlot);
        
        glBindVertexArrayOES(0);
    }

    /**
     *
     */
    public func update()
    {
        // print("VRDevViewController -> update");
        
        let aspect: CGFloat = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
        let projectionMatrix: GLKMatrix4 = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65), Float(aspect), 0.0, 10.0);
        self.effect.transform.projectionMatrix = projectionMatrix;
        
        if(self.motionManager.deviceMotion != nil)
        {
            // var modelviewMatrix: GLKMatrix4 = GLKMatrix4Identity;
            var modelviewMatrix: GLKMatrix4 = GLKMatrix4MakeTranslation(0.0, 0.0, 0.0);
            
            let rollRad: Float = Float(self.motionManager.deviceMotion!.attitude.roll);
            let rollRadRounded: Float = round(rollRad * 100) / 100
            
            let pitchRad: Float = Float(self.motionManager.deviceMotion!.attitude.pitch);
            let pitchRadRounded: Float = round(pitchRad * 100) / 100;
            
            let yawRad: Float = Float(self.motionManager.deviceMotion!.attitude.yaw);
            let yawRadRounded: Float = round(yawRad * 100) / 100;
            
            print("roll: \(rollRadRounded) | pitch: \(pitchRadRounded) | yaw: \(yawRadRounded)");
            
            
            modelviewMatrix = GLKMatrix4Rotate(modelviewMatrix, yawRadRounded, 0, 0, -1);
            modelviewMatrix = GLKMatrix4Rotate(modelviewMatrix, Float(M_PI_2), 1, 0, 0);
            
            modelviewMatrix = GLKMatrix4Rotate(modelviewMatrix, rollRadRounded, sin(yawRadRounded), 0, cos(yawRadRounded));
            modelviewMatrix = GLKMatrix4Rotate(modelviewMatrix, pitchRadRounded, -cos(yawRadRounded), 0, sin(yawRadRounded));
            
            self.effect.transform.modelviewMatrix = modelviewMatrix;
        }
        
        
        // var modelViewMatrix: GLKMatrix4 = GLKMatrix4MakeTranslation(0.0, 0.0, 0.0);
        // modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(Float(-self.rotationX)), 1, 0, 0);
        // modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, GLKMathDegreesToRadians(Float(-self.rotationY)), 0, 1, 0);
        // self.effect.transform.modelviewMatrix = modelViewMatrix;
    }
    
    /**
     *
     */
    public override func glkView(view: GLKView, drawInRect rect: CGRect)
    {
        // print("VRDevViewController -> glkView drawInRect");
        
        glClearColor(0.5, 0.5, 0.5, 1.0);
        glClear(GLenum(GL_COLOR_BUFFER_BIT));
        
        self.effect.prepareToDraw();
        
        glBindVertexArrayOES(self.vertexArray);
        glDrawElements(GLenum(GL_TRIANGLES), GLsizei(self.sphere.indices.count), GLenum(GL_UNSIGNED_BYTE), nil);
    }
    
    /**
     *
     */
    public override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
    {
        // print("VRDevViewController -> touchesBegan withEvent");
        // self.paused = !self.paused;
    }
    
    // MARK: Gesture recognizers
    
    internal var panBeganLocation: CGPoint = CGPointMake(0, 0);
    internal var panBeganRotationX: CGFloat = 0;
    internal var panBeganRotationY: CGFloat = 0;
    
    /**
     *
     */
    internal func panOnView(panGestureRecognizer: UIPanGestureRecognizer)
    {
        print("VRDevViewController -> panOnView");
        
        let location: CGPoint = panGestureRecognizer.locationInView(self.view);
        let state: UIGestureRecognizerState = panGestureRecognizer.state;
        
        if(state == UIGestureRecognizerState.Began)
        {
            self.panBeganLocation = location;
            self.panBeganRotationX = self.rotationX;
            self.panBeganRotationY = self.rotationY;
        }
        
        if(state == UIGestureRecognizerState.Changed)
        {
            let deltaX: CGFloat = location.x - self.panBeganLocation.x;
            let deltaY: CGFloat = location.y - self.panBeganLocation.y;
            
            // print(" => deltaX: \(deltaX) - deltaY: \(deltaY)");
            
            self.rotationY = self.panBeganRotationY + deltaX;
            self.rotationX = self.panBeganRotationX + deltaY;
        }
    }
}