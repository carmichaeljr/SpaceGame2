private abstract class Button extends InteractiveUIElement implements DisplayInterface {
	protected ButtonActionInterface buttonAction;
	
	public Button(){
		super();
		this.buttonAction=null;
	}
	
	public ButtonActionInterface getButtonAction(){
		return this.buttonAction;
	}
	public void setButtonAction(ButtonActionInterface buttonAction){
		this.buttonAction=buttonAction;
	}

	public abstract void display();
	public abstract void performMouseAction(String ... args);
	public abstract void performKeyboardAction(String ... args);
}
