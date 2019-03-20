private class MouseManager<T extends ComponentContainer> {
	private T componentContRef;
	private boolean mousePressed;
	private boolean mouseDragged;
	private boolean mouseReleased;
	private boolean running;
	
	public MouseManager(T componentContRef){
		this.componentContRef=componentContRef;
		this.mousePressed=false;
		this.mouseDragged=false;
		this.mouseReleased=false;
		this.running=false;
	}
	
	public boolean getMousePressed(){
		return this.mousePressed;
	}
	public void setMousePressed(boolean mousePressed){
		if (this.running){
			this.mousePressed=mousePressed;
		}
	}
	
	public boolean getMouseDragged(){
		return this.mouseDragged;
	}
	public void setMouseDragged(boolean mouseDragged){
		if (this.running){
			this.mouseDragged=mouseDragged;
		}
	}
	
	public boolean getMouseReleased(){
		return this.mouseReleased;
	}
	public void setMouseReleased(boolean mouseReleased){
		if (this.running){
			this.mouseReleased=mouseReleased;
		}
	}
	
	public void start(){
		this.running=true;
	}
	
	public void stop(){
		this.reset();
		this.running=false;
	}
	
	public void reset(){
		this.mousePressed=false;
		this.mouseDragged=false;
		this.mouseReleased=false;
	}
	
	public void update(){
		if (this.running){
			this.runMousePositionActions();
			if (this.mousePressed){
				this.runMousePressedActions();
			}
			if (this.mouseDragged){
				this.runMouseDraggedActions();
			}
			if (this.mouseReleased){
				this.runMouseReleasedActions();
			}
		}
	}

	//The following four functions are kept separate so they can easily be
	//	overrided in subclasses.
	protected void runMousePositionActions(){
		for (InteractiveUIElement iterElement: this.componentContRef.getInteractiveComponents()){
			if (iterElement.mouseInsideObject(mouseX,mouseY)){
				iterElement.performMouseAction("hovered");
			}
		}
	}
	protected void runMousePressedActions(){
		for (InteractiveUIElement iterElement: this.componentContRef.getInteractiveComponents()){
			if (iterElement.mouseInsideObject(mouseX,mouseY)){
				iterElement.performMouseAction("pressed");
			}
		}
	}
	protected void runMouseDraggedActions(){
		for (InteractiveUIElement iterElement: this.componentContRef.getInteractiveComponents()){
			if (iterElement.mouseInsideObject(mouseX,mouseY)){
				iterElement.performMouseAction("dragged");
			}
		}
	}
	protected void runMouseReleasedActions(){
		for (InteractiveUIElement iterElement: this.componentContRef.getInteractiveComponents()){
			if (iterElement.mouseInsideObject(mouseX,mouseY)){
				iterElement.performMouseAction("released");
			}
		}
	}
}
