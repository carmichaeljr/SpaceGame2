//abstract class FloatingButton extends Button {
//	private float[] constraints;
//	private float zRotationMovement;
//	
//	public FloatingButton(){
//		super();
//		this.zRotationMovement=0;
//		this.constraints=new float[2];
//	}
//	
//	public float getZRotationMovement(){
//		return this.zRotationMovement;
//	}
//	public void setZRotationMovement(float zRotationMovement){
//		this.zRotationMovement=zRotationMovement;
//	}
//	
//	public float[] getConstraints(){
//		return this.constraints;
//	}
//	public void setConstraints(float[] constraints){
//		this.constraints[0]=constraints[0];
//		this.constraints[1]=constraints[1];
//	}
//	public void setConstraints(float min, float max){
//		this.constraints[0]=min;
//		this.constraints[1]=max;
//	}
//	
//	protected void incrementZRotation(float incrementor){
//		super.setZRotation(super.getZRotation()+incrementor);
//		if (super.getZRotation()>TWO_PI){
//			super.setZRotation(super.getZRotation()-TWO_PI);
//		} else if (super.getZRotation()<-TWO_PI){
//			super.setZRotation(super.getZRotation()+TWO_PI);
//		}
//	}
//	
//	@Override
//	public void update(){
//		float tempX=super.x+super.movementX;
//		float tempY=super.y+super.movementY;
//		float tempZ=super.z+super.movementZ;
//		if (tempY<this.constraints[0] || tempY>this.constraints[1]){
//			super.setMovementY(-super.getMovementY());
//			tempY=constrain(tempY,this.constraints[0],this.constraints[1]);
//		}
//		super.setPosition(tempX,tempY,tempZ);
//		this.incrementZRotation(this.zRotationMovement);
//		if (super.pressed){
//			this.performMouseAction();
//		}
//	}
//	
//	public abstract void display();
//	protected abstract void displayContent();
//	public abstract void performMouseAction(String ... args);
//}
//

//private abstract class ButtonWithText extends Button {
//	protected ButtonFont buttonFont;
//	
//	public ButtonWithText(){
//		super();
//		this.buttonFont=new ButtonFont(1);
//	}
//	
//	@Override
//	public void setLocation(PVector pos){
//		super.setLocation(pos);
//		if (this.buttonFont!=null){
//			this.updateFont();
//		}
//	}
//	
//	@Override
//	public void setSize(float _width, float _height){
//		super.setSize(_width,_height);
//		if (this.buttonFont!=null){
//			this.updateFont();
//		}
//	}
//	
//	@Override
//	public void setContentColor(color c){
//		super.setContentColor(c);
//		if (this.buttonFont!=null){
//			this.updateFont();
//		}
//	}
//
//	protected abstract void updateFont();
//	public abstract void display();
//	public abstract void performMouseAction(String ... args);
//	public abstract void performKeyboardAction(String ... args);
//}

private class ButtonWithText extends Button {
	protected ButtonFont buttonFont;
	protected String name;
	
	public ButtonWithText(){
		super();
		this.buttonFont=new ButtonFont(1);
	}

	public ButtonWithText(String name){
		super();
		this.name=name;
		this.buttonFont=new ButtonFont(1);
		this.buttonFont.setDisplayText(name);
	}
	
	@Override
	public void setLocation(PVector pos){
		super.setLocation(pos);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}
	
	@Override
	public void setSize(float _width, float _height){
		super.setSize(_width,_height);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}
	
	@Override
	public void setContentColor(color c){
		super.setContentColor(c);
		if (this.buttonFont!=null){
			this.updateFont();
		}
	}

	protected void updateFont(){
		this.buttonFont.setFontSize(int(super._height*0.6));
		this.buttonFont.setLocation(new PVector(super.location.x,
			 super.location.y+super._height/4
		));
		this.buttonFont.setColor(super.getContentColor());
	}

	public void display(){
		super.setFillAndStroke();
		pushMatrix();
		translate(super.location.x,super.location.y);
		strokeWeight(3);
		rect(0,0,super._width,super._height);
		strokeWeight(1);
		popMatrix();
		this.displayContent();
		this.buttonFont.display();
	}

	protected void displayContent(){
		//
	}

	public void performMouseAction(String ... args){
		if (args.length>0){
			if (args[0].equalsIgnoreCase("hovered")){
				super.hovered=true;
			} else if (args[0].equalsIgnoreCase("released")){
				super.buttonAction.performButtonAction(this.name);
			}
		}
	}
	
	public void performKeyboardAction(String ... args){
		if (args.length>0){
			if (args[0].equalsIgnoreCase("released")){
				super.buttonAction.performButtonAction(this.name);
			}
		}
	}
}

//private abstract class ToggleButton extends ButtonWithText {
//	protected ButtonFont toggleFont;
//	protected boolean toggleOn;
//	
//	public ToggleButton(){
//		this.toggleFont=new ButtonFont(1);
//		this.toggleOn=true;
//		this.updateToggleFont();
//		this.setToggleFontText();
//	}
//	
//	public boolean getToggleOn(){
//		return this.toggleOn;
//	}
//	public void setToggleOn(boolean toggleOn){
//		this.toggleOn=toggleOn;
//		this.setToggleFontText();
//	}
//	
//	@Override
//	public void update(){
//		if (super.pressed){
//			this.toggleOn=!this.toggleOn;
//			this.setToggleFontText();
//			this.performMouseAction();
//			delay(250);
//		}
//	}
//	
//	protected abstract void updateToggleFont();
//	protected abstract void setToggleFontText();
//	protected abstract void updateFont();
//	public abstract void display();
//	public abstract void performMouseAction(String ... args);
//	public abstract void performKeyboardAction(String ... args);
//}
//
//
//private class DummyButton extends Button {
//	private String actionString;
//	
//	public DummyButton(String actionString){
//		super();
//		this.actionString=actionString;
//	}
//	
//	@Override
//	public void display(){
//		//
//	}
//	
//	@Override
//	public void performMouseAction(String ... args){
//		super.buttonAction.performButtonAction(actionString);
//	}
//
//	@Override
//	public void performKeyboardAction(String ... args){
//		super.buttonAction.performButtonAction(actionString);
//	}
//}

//private class PlayButton extends ButtonWithText implements KeyboardActionInterface {
//	public PlayButton(){
//		super();
//		super.buttonFont.setDisplayText("Play");
//	}
//	
//	@Override
//	protected void updateFont(){
//		super.buttonFont.setFontSize(int(super._height*0.6));
//		super.buttonFont.setLocation(new PVector(super.location.x,
//			 super.location.y+super._height/4
//		));
//		super.buttonFont.setColor(super.getContentColor());
//	}
//
//	@Override
//	public void display(){
//		super.setFillAndStroke();
//		pushMatrix();
//		translate(super.location.x,super.location.y);
//		strokeWeight(3);
//		rect(0,0,super._width,super._height);
//		strokeWeight(1);
//		popMatrix();
//		this.displayContent();
//		super.buttonFont.display();
//	}
//	
//	public void displayContent(){
//		pushMatrix();
//		translate(super.location.x-super._width/4,super.location.y);
//		fill(super.contentColor);
//		stroke(super.contentColor);
//		triangle(-super._width/8,-super._height/4,
//				 -super._width/8,super._height/4,
//				 super._width/8,0);
//		popMatrix();
//	}
//	
//	@Override
//	public void performMouseAction(String ... args){
//		super.buttonAction.performButtonAction("play");
//	}
//	
//	@Override
//	public void performKeyboardAction(String ... args){
//		super.buttonAction.performButtonAction("play");
//	}
//}

private class LevelButton extends ButtonWithText {
	private int level;
	private boolean _available;

	public LevelButton(int level){
		super();
		this.level=level;
		this._available=false;
		super.buttonFont.setDisplayText(String.format("Level %d",this.level+1));
	}

	public void setAvailable(boolean _available){
		this._available=_available;
	}

	public void setLevel(int level){
		this.level=level;
		super.buttonFont.setDisplayText(String.format("Level %d",this.level+1));
	}

	@Override
	protected void updateFont(){
		super.buttonFont.setFontSize(int(super._height*0.6));
		super.buttonFont.setLocation(new PVector(super.location.x-15,
			super.location.y+super._height/4
		));
		super.buttonFont.setColor(super.getContentColor());
	}

	@Override
	public void display(){
		super.setFillAndStroke();
		pushMatrix();
		translate(super.location.x,super.location.y);
		strokeWeight(3);
		rect(0,0,super._width,super._height);
		strokeWeight(1);
		popMatrix();
		this.displayContent();
		super.buttonFont.display();
	}

	protected void displayContent(){
		pushMatrix();
		if (this._available){
			translate(super.location.x-super._width/4,super.location.y);
			//fill(super.contentColor);
			//stroke(super.contentColor);
			fill(10,100,10);
			stroke(50,100,50);
			triangle(-super._width/16,-super._height/4,
				 -super._width/16,super._height/4,
				  super._width/16,0);
		} else {
			translate(super.location.x-super._width/4,super.location.y);
			strokeWeight(3);
			noFill();
			stroke(255,150,0);
			//stroke(super.contentColor);
			ellipse(0,0,super._width/10,super._width/8);
			fill(255,150,0);
			//fill(super.contentColor);
			rect(0,super._height/8,super._width/8,super._width/8,super._height/20);
			strokeWeight(1);
		}
		popMatrix();
	}

	@Override
	public void performMouseAction(String ... args){
		if (this._available && args.length>0){
			if (args[0].equalsIgnoreCase("hovered")){
				super.hovered=true;
			} else if (args[0].equalsIgnoreCase("released")){
				super.buttonAction.performButtonAction("play",String.format("%d",this.level));
			}
		}
	}
	
	@Override
	public void performKeyboardAction(String ... args){
		if (this._available && args.length>0){
			if (args[0].equalsIgnoreCase("released")){
				super.buttonAction.performButtonAction("play",String.format("%d",this.level));
			}
		}
	}
}

private class HelpButton extends ButtonWithText {
	public HelpButton(){
		super();
		super.name="help";
		super.buttonFont.setDisplayText("?");
	}
	
	@Override
	protected void updateFont(){
		super.buttonFont.setFontSize(int(super._height*0.6));
		super.buttonFont.setLocation(new PVector(super.location.x-7,
			super.location.y+super._height/4
		));
		super.buttonFont.setColor(super.getContentColor());
	}

	@Override
	public void display(){
		super.setFillAndStroke();
		pushMatrix();
		translate(super.location.x,super.location.y);
		strokeWeight(3);
		ellipse(0,0,super._width,super._height);
		strokeWeight(1);
		this.displayContent();
		popMatrix();
		this.buttonFont.display();
	}
}

private class PauseButton extends Button {
	public PauseButton(){
		super();
	}
	
	@Override
	public void display(){
		super.setFillAndStroke();
		pushMatrix();
		translate(super.location.x,super.location.y);
		strokeWeight(3);
		rect(0,0,super._width,super._height);
		strokeWeight(1);
		this.displayContent();
		popMatrix();
	}
	
	protected void displayContent(){
		fill(super.contentColor);
		stroke(super.contentColor);
		rect(-super._width/8,0,super._width/10,super._height/3,3);
		rect(super._width/8,0,super._width/10,super._height/3,3);
	}
	
	@Override
	public void performMouseAction(String ... args){
		if (args.length>0){
			if (args[0].equalsIgnoreCase("hovered")){
				super.hovered=true;
			} else if (args[0].equalsIgnoreCase("released")){
				super.buttonAction.performButtonAction("pause");
			}
		}
	}
	
	@Override
	public void performKeyboardAction(String ... args){
		if (args.length>0){
			if (args[0].equalsIgnoreCase("released")){
				super.buttonAction.performButtonAction("pause");
			}
		}
	}
}
//
//
//class GameMusicToggle extends ToggleButton {
//	private String actionString;
//	
//	public GameMusicToggle(String actionString, String buttonName){
//		super();
//		super.buttonFont.setDisplayText(buttonName);
//		this.actionString=actionString;
//	}
//	
//	public String getActionString(){
//		return this.actionString;
//	}
//	public void setActionString(String actionString){
//		this.actionString=actionString;
//	}
//	
//	@Override
//	protected void updateFont(){
//		super.buttonFont.setFontSize(int(super.getHeight()*0.5));
//		super.buttonFont.setPosition(super.getX()-(11*super.getWidth()/24),
//									 super.getY()+super.getHeight()/4,
//									 super.getZ()+super.getDepth()/2);
//		super.buttonFont.setForegroundColor(super.getContentColor());
//		this.updateToggleFont();
//	}
//	
//	@Override
//	protected void updateToggleFont(){
//		if (super.toggleFont!=null){
//			super.toggleFont.setFontSize(int(super.getHeight()*0.25));
//			super.toggleFont.setPosition(super.getX()+super.getWidth()/8,
//										 super.getY()+super.getHeight()/4,
//										 super.getZ()+super.getDepth()/2);
//			super.toggleFont.setForegroundColor(super.getContentColor());
//		}
//	}
//	
//	@Override
//	protected void setToggleFontText(){
//		super.toggleFont.setDisplayText((super.toggleOn)? "On": "Off");
//	}
//
//	@Override
//	public void display(){
//		super.setFillAndStroke();
//		super.performTranslation();
//		strokeWeight(3);
//		box(super.getWidth(),super.getHeight(),super.getDepth());
//		super.resetTranslation();
//		this.displayContent();
//		strokeWeight(1);
//		super.buttonFont.display();
//		this.toggleFont.display();
//	}
//	
//	public void displayContent(){
//		pushMatrix();
//		translate(super.x+super.getWidth()/4,super.y-super.getHeight()/4,super.z+super._depth/2);
//		rectMode(CENTER);
//		strokeWeight(2);
//		fill((super.toggleOn)? super.getContentColor(): super.getMainColor());
//		stroke(super.getContentColor());
//		rect(0,0,super.getWidth()/4,super.getHeight()/4,super.getWidth()/8);
//		strokeWeight(1);
//		fill((super.toggleOn)? super.getMainColor(): super.getContentColor());
//		if (this.toggleOn){
//			rect(super.getWidth()/16,0,super.getWidth()/8,super.getHeight()/4,super.getWidth()/8);
//		} else {
//			rect(-super.getWidth()/16,0,super.getWidth()/8,super.getHeight()/4,super.getWidth()/8);
//		}
//		popMatrix();
//	}
//	
//	@Override
//	public void performMouseAction(String ... args){
//		super.buttonAction.performButtonAction(this.actionString,String.format("%b",this.toggleOn));
//	}
//}
