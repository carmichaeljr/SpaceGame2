private class KeyboardManager<T extends ComponentContainer> {
	protected T componentContRef;
	protected ArrayList<Character> keyBuffer;
	protected boolean keyPressed;
	protected boolean keyReleased;
	protected boolean running;
	
	public KeyboardManager(T componentContRef){
		this.componentContRef=componentContRef;
		this.keyBuffer=new ArrayList<Character>();
		this.keyPressed=false;
		this.keyReleased=false;
	}
	
	public void setKeyPressed(boolean keyPressed){
		this.keyPressed=keyPressed;
		if (keyPressed){
			this.addKeyPressToBuffer(key);
		}
	}
	public boolean getKeyPressed(){
		return this.keyPressed;
	}
	
	public void setKeyReleased(boolean keyReleased){
		this.keyReleased=keyReleased;
		if (keyReleased){
			this.removeKeyPressFromBuffer(key);
		}
	}
	public boolean getKeyReleased(){
		return this.keyReleased;
	}

	private void addKeyPressToBuffer(char newChar){
		boolean contains=false;
		for (int i=0; i<this.keyBuffer.size() && !contains; i++){
			if (this.keyBuffer.get(i).equals(newChar)){
				contains=true;
			}
		}
		if (!contains){
			this.keyBuffer.add(new Character(newChar));
		}
	}

	private void removeKeyPressFromBuffer(char token){
		for (int i=this.keyBuffer.size()-1; i>=0; i--){
			if (this.keyBuffer.get(i).equals(token)){
				this.keyBuffer.remove(i);
			}
		}
	}
	
	public void start(){
		this.running=true;
	}
	
	public void stop(){
		this.reset();
		this.running=false;
		this.keyBuffer.clear();
	}
	
	public void reset(){
		this.keyPressed=false;
		this.keyReleased=false;
	}
	
	public void update(){
		if (this.running){
			if (this.keyPressed){
				this.runSingleKeyPressActions();
			}
			if (this.keyReleased){
				this.runSingleKeyReleaseActions();
			}
			this.runRepeatedKeyPressActions();
		}
	}

	//The following three functions are kept separate so they can easily be
	//	overrided in subclasses.
	protected void runSingleKeyPressActions(){
		for (InteractiveUIElement iterElement: this.componentContRef.getInteractiveComponents()){
			if (iterElement.getKeyPressedTrigger()==key){
				iterElement.performKeyboardAction("pressed");
			}
		}
	}
	protected void runSingleKeyReleaseActions(){
		for (InteractiveUIElement iterElement: this.componentContRef.getInteractiveComponents()){
			if (iterElement.getKeyReleasedTrigger()==key){
				iterElement.performKeyboardAction("released");
			}
		}
		
	}
	protected void runRepeatedKeyPressActions(){
		//
	}
}
