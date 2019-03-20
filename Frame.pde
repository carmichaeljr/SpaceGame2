private abstract class Frame<T extends CrossFrameData> implements ButtonActionInterface {
	protected T crossFrameData;
	//protected U ComponentManager;
	//protected V KeyboardManager;
	//protected W MouseManager;
	protected String id;
	protected boolean active;

	public Frame(String id, T crossFrameData){
		this.id=id.toLowerCase();
		this.active=false;
		this.crossFrameData=crossFrameData;
	}

	public void setActive(boolean active){;
		this.active=active;
	}
	public boolean getActive(){
		return this.active;
	}

	public String getID(){
		return this.id;
	}
	
	public abstract KeyboardManager getKeyboardManager();
	public abstract MouseManager getMouseManager();
	public abstract ComponentManager getComponentManager();

	public void start(){
		this.getKeyboardManager().start();
		this.getMouseManager().start();
		this.active=true;
	}
	public void update(){
		this.getComponentManager().update();
		this.getKeyboardManager().update();
		this.getMouseManager().update();
	}
	public void display(){
		this.getComponentManager().display();
	}
	public void reset(){
		this.getKeyboardManager().reset();
		this.getMouseManager().reset();
		this.getComponentManager().reset();
	}
	public void stop(){
		this.getKeyboardManager().stop();
		this.getMouseManager().stop();
		this.active=false;
	}

	public void run(){
		this.update();
		this.display();
		this.reset();
	}

	public abstract void performButtonAction(String ... args);
}
