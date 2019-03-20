//TODO - What game play is there?????
//	 What is the overall goal of the game???
//	Make boss proper weight
//	Add boss oponents to progress bar

import java.util.Iterator;
import java.util.IllegalFormatConversionException;

private final GameArea GAME_AREA=new GameArea(new PVector(3000,600));
private final int MAX_LEVEL=3;
private boolean DEBUG=false;
private GameManager gameManager;
private MenuBackground BACKGROUND;

public void settings(){
	size(800,600,P2D);
	pixelDensity(displayDensity());
}

public void setup(){
	rectMode(CENTER);
	imageMode(CENTER);
	ellipseMode(CENTER);
	this.showSplashScreen();
	this.BACKGROUND=new MenuBackground();
	this.gameManager=new GameManager();
}

public void draw(){
	background(0);
	if (!this.gameManager.getExit()){
		this.gameManager.run();
	} else {
		this.exit();
	}
}

public void keyPressed(){
	this.gameManager.setKeyPressed();
}
public void keyReleased(){
	this.gameManager.setKeyReleased();		
}
public void mouseReleased(){
	this.gameManager.setMouseReleased();
}

@Override
public void exit(){
	this.gameManager.exit();
	super.exit();
}



