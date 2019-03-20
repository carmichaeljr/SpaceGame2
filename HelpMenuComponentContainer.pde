private class HelpMenuComponentContainer extends MenuComponentContainer {
	private ImageWrapper keysImage;
	private ButtonWithText backButton;
	private MenuDisplayFont helpText;
	private MenuDisplayFont helpText2;

	public HelpMenuComponentContainer(){
		this.setupKeysImage();
		this.setupBackButton();
		this.setupHelpText();
		this.setupHelpText2();
		this.setupUpdateComponents();
		this.setupDisplayComponents();
		this.setupResetComponents();
		this.setupInteractiveComponents();
	}

	private void setupKeysImage(){
		this.keysImage=new ImageWrapper("data/KeyboardShortcuts.png");
		this.keysImage.resizePorpotionally('w',width/2+width/4);
		this.keysImage.setLocation(new PVector(width/2+width/8,height-this.keysImage.getHeight()/2));
	}

	private void setupBackButton(){
		this.backButton=new ButtonWithText("Back"){
			@Override
			protected void displayContent(){
				pushMatrix();
				translate(super.location.x-super._width/3,super.location.y);
				strokeWeight(3);
				stroke(super.getContentColor());
				line(0,0,super._width/8,0);
				line(0,0,super._width/16,super._width/16);
				line(0,0,super._width/16,-super._width/16);
				strokeWeight(1);
				popMatrix();
			}
		};
		this.backButton.setLocation(new PVector(width/8,height*0.4));
		this.backButton.setSize(width/4,75);
		this.backButton.setMainColor(color(58,58,58));
		this.backButton.setHoverColor(color(145,145,145));
		this.backButton.setContentColor(color(186,186,186));
		this.backButton.updateFont();
		this.backButton.setKeyReleasedTrigger('b');
	}

	public void setupHelpText(){
		String helpText=new String("Certain keyboard shortcuts are only available at certain times.");
		helpText=String.format("%s\n%s",helpText,"'x' is available in any menu to exit.");
		helpText=String.format("%s\n%s",helpText,"During the Game:");
		helpText=String.format("%s\n   %s",helpText,"a,w,s,d - Direct your ship");
		helpText=String.format("%s\n   %s",helpText,"f - Toggles displaying frame rate");
		helpText=String.format("%s\n   %s",helpText,"p - Pauses the game");
		helpText=String.format("%s\n   %s",helpText,"i - Toggles displaying debug");
		helpText=String.format("%s\n%s",helpText,"Pause Menu:");
		helpText=String.format("%s\n   %s",helpText,"p - Resumes the current game");
		helpText=String.format("%s\n   %s",helpText,"e - Ends the current game");
		helpText=String.format("%s\n%s",helpText,"Help Menu:");
		helpText=String.format("%s\n   %s",helpText,"b - Back to the main menu");
		this.helpText=new MenuDisplayFont(20);
		this.helpText.setLocation(new PVector(width/4+20,30));
		this.helpText.setColor(color(100,0,0));
		this.helpText.setDisplayText(helpText);
	}

	private void setupHelpText2(){
		String helpText2=new String("Reset Menu:");
		helpText2=String.format("%s\n   %s",helpText2,"y - Yes");
		helpText2=String.format("%s\n   %s",helpText2,"n - No");
		helpText2=String.format("%s\n%s",helpText2,"Main Menu:");
		helpText2=String.format("%s\n   %s",helpText2,"1,2,3 - Play level 1,2,3 respectively");
		helpText2=String.format("%s\n   %s",helpText2,"h - Go to the help menu");
		helpText2=String.format("%s\n   %s",helpText2,"r - Go to reset menu");
		this.helpText2=new MenuDisplayFont(20);
		this.helpText2.setLocation(new PVector(2*width/3,80));
		this.helpText2.setColor(color(100,0,0));
		this.helpText2.setDisplayText(helpText2);
	}

	private void setupUpdateComponents(){
		//
	}
	private void setupDisplayComponents(){
		super.addDisplayComponent(this.keysImage);
		super.addDisplayComponent(this.backButton);
		super.addDisplayComponent(this.helpText);
		super.addDisplayComponent(this.helpText2);
	}
	private void setupResetComponents(){
		super.addResetComponent(this.backButton);
	}
	private void setupInteractiveComponents(){
		super.addInteractiveComponent(this.backButton);
	}

	public ButtonWithText getBackButton(){
		return this.backButton;
	}
	public ButtonWithText getExitButton(){
		return this.exitButton;
	}
}
