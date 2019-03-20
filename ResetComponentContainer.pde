private class ResetComponentContainer extends MenuComponentContainer {
	private ButtonWithText yesButton;
	private ButtonWithText noButton;
	private MenuDisplayFont confirmationText;

	public ResetComponentContainer(){
		this.setupYesButton();
		this.setupNoButton();
		this.setupComformationText();
		this.setupUpdateComponents();
		this.setupDisplayComponents();
		this.setupResetComponents();
		this.setupInteractiveComponents();
	}

	private void setupYesButton(){
		this.yesButton=new ButtonWithText("Yes"){
			@Override
			protected void displayContent(){
				pushMatrix();
				translate(super.location.x-super._width/3,super.location.y+super._height/4);
				strokeWeight(3);
				stroke(0,100,0);
				line(0,0,super._width/8,-super._width/8);
				line(0,0,-super._width/16,-super._width/16);
				strokeWeight(1);
				popMatrix();
			}
		};
		this.yesButton.setLocation(new PVector(width/8,height*0.4));
		this.yesButton.setSize(width/4,75);
		this.yesButton.setMainColor(color(58,58,58));
		this.yesButton.setHoverColor(color(145,145,145));
		this.yesButton.setContentColor(color(186,186,186));
		this.yesButton.updateFont();
		this.yesButton.setKeyReleasedTrigger('b');
	}

	private void setupNoButton(){
		this.noButton=new ButtonWithText("No"){
			@Override
			protected void displayContent(){
				float xDist=(super._width/8)*cos(PI/4);
				float yDist=(super._width/8)*sin(PI/4);
				pushMatrix();
				translate(super.location.x-super._width/3,super.location.y);
				strokeWeight(3);
				stroke(100,0,0);
				noFill();
				ellipse(0,0,super._width/4,super._width/4);
				line(xDist,-yDist,-xDist,yDist);
				strokeWeight(1);
				popMatrix();
			}
		};
		this.noButton.setLocation(new PVector(width/8,height*0.4+75));
		this.noButton.setSize(width/4,75);
		this.noButton.setMainColor(color(58,58,58));
		this.noButton.setHoverColor(color(145,145,145));
		this.noButton.setContentColor(color(186,186,186));
		this.noButton.updateFont();
		this.noButton.setKeyReleasedTrigger('b');
	}

	private void setupComformationText(){
		this.confirmationText=new MenuDisplayFont(40);
		this.confirmationText.setLocation(new PVector(width/3.7,height*0.4+75/2));
		this.confirmationText.setColor(color(100,0,0));
		this.confirmationText.setDisplayText("Are you sure?");
	}

	private void setupUpdateComponents(){
		//
	}
	private void setupDisplayComponents(){
		super.addDisplayComponent(this.yesButton);
		super.addDisplayComponent(this.noButton);
		super.addDisplayComponent(this.confirmationText);
	}
	private void setupResetComponents(){
		super.addResetComponent(this.yesButton);
		super.addResetComponent(this.noButton);
	}
	private void setupInteractiveComponents(){
		super.addInteractiveComponent(this.yesButton);
		super.addInteractiveComponent(this.noButton);
	}

	public ButtonWithText getYesButton(){
		return this.yesButton;
	}
	public ButtonWithText getNoButton(){
		return this.noButton;
	}
	public ButtonWithText getExitButton(){
		return this.exitButton;
	}
}
