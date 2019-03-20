private abstract class InteractiveUIElement extends UIElement implements 
	ResetInterface, MouseActionInterface, KeyboardActionInterface {
	protected color mainColor;
	protected color hoverColor;
	protected color contentColor;
	protected char keyPressedTrigger;
	protected char keyReleasedTrigger;
	protected boolean hovered;
	protected boolean pressed;
	
	public InteractiveUIElement(){
		super();
		this.mainColor=color(0,0,0);
		this.hoverColor=color(0,0,0);
		this.contentColor=color(0,0,0);
		this.keyPressedTrigger=0;
		this.keyReleasedTrigger=0;
		this.hovered=false;
		this.pressed=false;
	}

	public color getMainColor(){
		return this.mainColor;
	}
	public void setMainColor(color mainColor){
		this.mainColor=mainColor;
	}
	
	public color getHoverColor(){
		return this.hoverColor;
	}
	public void setHoverColor(color hoverColor){
		this.hoverColor=hoverColor;
	}
	
	public color getContentColor(){
		return this.contentColor;
	}
	public void setContentColor(color contentColor){
		this.contentColor=contentColor;
	}

	public boolean getHovered(){
		return this.hovered;
	}
	public void setHovered(boolean hovered){
		this.hovered=hovered;
	}
	public void setHovered(float mousex, float mousey){
		this.hovered=this.mouseInsideObject(mousex,mousey);
	}
	
	public boolean getPressed(){
		return this.pressed;
	}
	public void setPressed(boolean pressed){
		this.pressed=pressed;
	}
	public void setPressed(float mousex, float mousey){
		this.pressed=this.mouseInsideObject(mousex,mousey);
	}

	public char getKeyPressedTrigger(){
		return this.keyPressedTrigger;
	}
	public void setKeyPressedTrigger(char keyPressedTrigger){
		this.keyPressedTrigger=keyPressedTrigger;
	}

	public char getKeyReleasedTrigger(){
		return this.keyReleasedTrigger;
	}
	public void setKeyReleasedTrigger(char keyReleasedTrigger){
		this.keyReleasedTrigger=keyReleasedTrigger;
	}

	public boolean mouseInsideObject(float mousex, float mousey){
		if (mousex>super.location.x-super._width/2 && 
			mousex<super.location.x+super._width/2 &&
			mousey>super.location.y-super._height/2 &&
			mousey<super.location.y+super._height/2){
			return true;
		}
		return false;
	}

	public void setFillAndStroke(){
		if (this.hovered || this.pressed){
			fill(this.hoverColor);
			stroke(this.mainColor);
		} else {
			fill(this.mainColor);
			stroke(this.hoverColor);
		}
	}

	public void reset(){
		this.hovered=false;
		this.pressed=false;
	}

	public abstract void display();
	public abstract void performMouseAction(String ... args);
	public abstract void performKeyboardAction(String ... args);
}
