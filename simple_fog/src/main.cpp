#define WIN32_LEAN_AND_MEAN
#define WIN32_EXTRA_LEAN

#define GLX_GLXEXT_LEGACY //Must be declared so that our local glxext.h is picked up, rather than the system one
#include <GL/Glew.h>
#include <GLFW/glfw3.h>
#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

// standard C++ libraries
#include <cassert>
#include <iostream>
#include <stdexcept>
#include <cmath>


#include "example.h"



GLFWwindow* gWindow = NULL;

void OnError(int errorCode, const char* msg) {
    throw std::runtime_error(msg);
}


int main(int argc, char** argv)
{
    //Set our window settings
    const int windowWidth = 1024;
    const int windowHeight = 768;
    const int windowBPP = 16;
    const int windowFullscreen = false;
    
    glfwSetErrorCallback(OnError);
    if(!glfwInit())
    throw std::runtime_error("glfwInit failed");
    
    // open a window with GLFW
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 2);
    glfwWindowHint(GLFW_RESIZABLE, GL_TRUE);
    gWindow = glfwCreateWindow(windowWidth, windowHeight, "OpenGL Tutorial - Simple Fog", NULL, NULL);
    if(!gWindow)
    throw std::runtime_error("glfwCreateWindow failed. Can your hardware handle OpenGL 3.2?");
    
    // GLFW settings
    glfwMakeContextCurrent(gWindow);
    
    // initialise GLEW
    glewExperimental = GL_TRUE; //stops glew crashing on OSX :-/
    if(glewInit() != GLEW_OK)
    throw std::runtime_error("glewInit failed");
    
    while(glGetError() != GL_NO_ERROR) {}
    
    // print out some info about the graphics drivers
    std::cout << "OpenGL version: " << glGetString(GL_VERSION) << std::endl;
    std::cout << "GLSL version: " << glGetString(GL_SHADING_LANGUAGE_VERSION) << std::endl;
    std::cout << "Vendor: " << glGetString(GL_VENDOR) << std::endl;
    std::cout << "Renderer: " << glGetString(GL_RENDERER) << std::endl;
    
    // make sure OpenGL version 3.2 API is available
    if(!GLEW_VERSION_3_2)
    throw std::runtime_error("OpenGL 3.2 API is not available.");
    
    Example example;
    
    example.init();
    
    //This is the mainloop, we render frames until isRunning returns false
    double lastTime = glfwGetTime();
    
    // run while the window is open
    while(!glfwWindowShouldClose(gWindow)){
        // process pending events
        glfwPollEvents();
        
        double thisTime = glfwGetTime();
        //Update((float)(thisTime - lastTime));
        example.prepare((float)(thisTime - lastTime));
        lastTime = thisTime;
        
        if (glfwGetKey(gWindow, GLFW_KEY_SPACE))
        {
            example.toggleFogMode();
        }
        
        
        // draw one frame
        example.render();
        
        GLenum error = glGetError();
        if(error != GL_NO_ERROR)
        std::cerr << "OpenGL Error " << error << std::endl;
        
        //exit program if escape key is pressed
        if(glfwGetKey(gWindow, GLFW_KEY_ESCAPE))
        glfwSetWindowShouldClose(gWindow, GL_TRUE);
        
        glfwSwapBuffers(gWindow);
    }
    
    // clean up and exit
    glfwTerminate();
    
    return 0; //Return success
}
