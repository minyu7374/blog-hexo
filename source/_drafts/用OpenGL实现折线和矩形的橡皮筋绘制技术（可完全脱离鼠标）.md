---
title: "用OpenGL实现折线和矩形的橡皮筋绘制技术（可完全脱离鼠标）"
date: "2015-04-01T16:13:00+08:00"
categories:
tags:
---

                                            
        这学期开始学计算机图形学基础，课后有个习题让用OpenGL实现折线和矩形的橡皮筋绘制技术，只要求了用右键菜单实现功能的选择。老师嫌有些简单，就说要加上教材上基于键盘实现的代码，可教材上的代码还是要先把鼠标移到一个点上，再用按键确定这个点，这样配合着使用很别扭。我想既然用键盘了，不如直接写个可以完全由键盘控制绘图过程的代码吧。
        正好现在我想学下Python，就决定拿这道题开始练手。代码虽然很简单，但写的过程中，一边要学Python的语法，一边又要查OpenGL的库函数，还是挺费精力的。这算是我第一次用Python写代码，结果还算满意，写个博客纪念下吧。
        程序用鼠标完成绘图就不用说了。键盘方面  A、D、W、X 用于移动窗口内的点，P用于选定某一点，L、 R、 C 分别为菜单各功能的快捷键，用于选择画折线、画矩形或清除图形。所有按键不区分大小写。为了使程序使用方便，键盘和鼠标没做什么限制，既可以分别使用，也可以结合使用。代码如下：


```python
#!/usr/bin/python
from OpenGL.GL import *
from OpenGL.GLU import *
from OpenGL.GLUT import *

iMode=1
winWidth = 800; winHeight = 600
num = 0; a = [0]*100; b = [0]*100
w1 = 200; h1 = 500; w2 = 200; h2 = 500
iPointNum = 0; x1 = 200; y1 = 500; x2 = 200; y2 = 500

def ChangeSize(w, h): 
    global winWidth, winHeight
    winWidth = w
    winHeight = h
    glViewport(0, 0, w, h)
    glMatrixMode(GL_PROJECTION)
    glLoadIdentity()
    gluOrtho2D(0.0, winWidth, 0.0, winHeight)

def ProcessMenu(value):
    global iMode
    iMode = value
    glutPostRedisplay()

def DrawPoint(x , y):
    glClear(GL_COLOR_BUFFER_BIT)
    glPointSize(1.5)
    glBegin(GL_POINTS)
    glVertex2i(x, y)
    glEnd()
    glutSwapBuffers()


def Draw():
    glClearColor(0.0, 0.0, 0.0, 0.0)
    glClear(GL_COLOR_BUFFER_BIT)
    glColor3f(1.0, 0.0, 0.0)
    
    global num, iMode, w1, h1, w2, h2, x1, x2, y1, y2, iPointNum, a, b
    #Line
    if iMode == 1:
        glBegin(GL_LINE_STRIP)
        for i in range(0, num):
            glVertex2i(a[i], b[i])
        glEnd()
    
        if num > 0:  
            glBegin(GL_LINES)
            glVertex2i(w1, h1)
            glVertex2i(w2, h2)
            glEnd()

    #Rectangle    
    elif iMode == 2 and iPointNum > 0:
        glBegin(GL_LINES)
        glVertex2i(x1, y1)
        glVertex2i(x2, y1)
        glEnd()

        glBegin(GL_LINES)
        glVertex2i(x1, y1)
        glVertex2i(x1, y2)
        glEnd()

        glBegin(GL_LINES)
        glVertex2i(x2, y1)
        glVertex2i(x2, y2)
        glEnd()

        glBegin(GL_LINES)
        glVertex2i(x1, y2)
        glVertex2i(x2, y2)
        glEnd()

    elif iMode == 3:
        num = 0
        iPointNum = 0
        w1 = w2 = x1 = x2 = 200
        h1 = h2 = y1 = y2 = 500
    
    glutSwapBuffers()

def MousePlot(button, action, xMouse, yMouse):
    global num, iMode, winHeight, w1, h1, w2, h2, x1, x2, y1, y2, iPointNum, a, b
    if iMode == 1:
    	if button == GLUT_LEFT_BUTTON and action == GLUT_DOWN:
	    if num == 0:
		w1 = xMouse
		h1 = winHeight - yMouse
		a[num] = w1; b[num] = h1
		num += 1
	    else:
                w2 = xMouse
                h2 = winHeight - yMouse
		a[num] = w2; b[num] = h2
		num += 1
		w1 = w2; h1 = h2
		glutPostRedisplay()				
	elif button == GLUT_RIGHT_BUTTON and action == GLUT_DOWN:
	    num = 0
	    glutPostRedisplay()
	
    elif iMode == 2:
	if button == GLUT_LEFT_BUTTON and action == GLUT_DOWN:
	    if iPointNum == 0 or iPointNum == 2:
		iPointNum = 1
		x1 = xMouse
		y1 = winHeight - yMouse
            else:
	        iPointNum = 2
	        x2 = xMouse
	        y2 = winHeight - yMouse
	        glutPostRedisplay()
	elif button == GLUT_RIGHT_BUTTON and action == GLUT_DOWN:
	    iPointNum = 0

def Key(key, xMouse, yMouse):
    global num, iMode, winWidth, winHeight, w1, h1, w2, h2, x1, x2, y1, y2, iPointNum
    #python has no switch statements
    if key == 'l' or key == 'L':
        iMode = 1
        glutPostRedisplay()

    elif key == 'r' or key == 'R':
        iMode = 2
        glutPostRedisplay()

    elif key == 'c' or key =='C':
        iMode = 3
        glutPostRedisplay()

    elif key == 'p' or key == 'P':
        if iMode == 1:
            if num == 0:
                a[num] = w1; b[num] = h1
                num += 1
            else:
                a[num] = w2; b[num] = h2
                num += 1
                w1 = w2; h1 = h2
                glutPostRedisplay()
        
        elif iMode == 2:
            if iPointNum == 0 or iPointNum == 2:
                iPointNum = 1
            else:
                iPointNum = 2
                glRecti(x1, y1, x2, y2)
                glutSwapBuffers()

    elif key == 'a' or key == 'A':
        if iMode == 1:
            if num == 0:
                if w1 >= 5:
                    w1 -= 5
                DrawPoint(w1, h1)
            else:
                if w2 >= 5:
                    w2 -= 5
                    glutPostRedisplay()

        elif iMode == 2:
            if iPointNum == 0 or iPointNum == 2:
                if x1 >= 5:
                    x1 -= 5
                DrawPoint(x1, y1)
            else:
                if x2 >= 5:
                    x2 -= 5
                glutPostRedisplay()
    elif  key == 'd' or key == 'D':
        if iMode == 1:
            if num == 0:
                if w1 <= winWidth - 5:
                    w1 += 5
                DrawPoint(w1, h1)
            else:
                if w2 <= winWidth - 5:
                    w2 += 5
                    glutPostRedisplay()

        elif iMode == 2:
            if iPointNum == 0 or iPointNum == 2:
                if x1 <= winWidth - 5:
                    x1 += 5                
                DrawPoint(x1, y1)
            else:
                if x2 <= winWidth - 5:
                    x2 += 5
                glutPostRedisplay()

    elif  key == 'w' or key == 'W':
        if iMode == 1:
            if num == 0:
                if h1 <= winHeight - 5:
                    h1 += 5
                DrawPoint(w1, h1)
            else:
                if h2 <= winHeight - 5:
                    h2 += 5
                    glutPostRedisplay()

        elif iMode == 2:
            if iPointNum == 0 or iPointNum == 2:
                if y1 <= winHeight - 5:
                    y1 += 5
                DrawPoint(x1, y1)
            else:
                if y2 <= winHeight - 5:
                    y2 += 5
                glutPostRedisplay()

    elif  key == 'x' or key == 'X':
        if iMode == 1:
            if num == 0:
                if h1 >= 5:
                    h1 -= 5
                DrawPoint(w1, h1)
            else:
                if h2 >= 5:
                    h2 -= 5
                    glutPostRedisplay()

        elif iMode == 2:
            if iPointNum == 0 or iPointNum == 2:
                if y1 >= 5:
                    y1 -= 5
                DrawPoint(x1, y1)
            else:
                if y2 >= 5:
                    y2 -= 5
                glutPostRedisplay()
        
def PassiveMouseMove(xMouse, yMouse):
    global iMode, num, w2, h2, x1, y1, x2, y2, winHeight, iPointNum
    if iMode == 1:
	if num > 0:
	    w2 = xMouse
	    h2 = winHeight - yMouse
	    glutPostRedisplay()

    elif iMode == 2:
	if iPointNum == 1:
	    x2 = xMouse
	    y2 = winHeight - yMouse
	    glutPostRedisplay()
        elif iPointNum == 2:
            glRecti(x1, y1, x2, y2)
            glutSwapBuffers()

glutInit()
glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA)
glutInitWindowSize(800, 600)
glutInitWindowPosition(100, 100)
glutCreateWindow("3-11 Line and Rectangle")
glutCreateMenu(ProcessMenu)
glutAddMenuEntry("Line(L)", 1)
glutAddMenuEntry("Rectangle(R)", 2)
glutAddMenuEntry("Clear(C)", 3)
glutAttachMenu(GLUT_RIGHT_BUTTON)
glutDisplayFunc(Draw)
glutReshapeFunc(ChangeSize)
glutKeyboardFunc(Key)
glutMouseFunc(MousePlot)
glutPassiveMotionFunc(PassiveMouseMove)
glutMainLoop()
```
