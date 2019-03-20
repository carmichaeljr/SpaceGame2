private class PauseMenuComponentContainer extends ComponentContainer {
	private SideMenu sideMenu;
	private ButtonWithText endButton;
	private ButtonWithText exitButton;
	private LevelButton resumeButton;
	private MenuDisplayFont endLabel;
	private MenuDisplayFont resumeLabel;
	private MenuDisplayFont menuTitleFont;

	public PauseMenuComponentContainer(){
		super();
		this.setupSideMenu();
		this.setupEndButton();
		this.setupExitButton();
		this.setupResumeLabel();
		this.setupEndLabel();
		this.setupResumeButton();
		this.setupMenuTitleFont();
		this.setupUpdateComponents();
		this.setupDisplayComponents();
		this.setupResetComponents();
		this.setupInteractiveComponents();
	}

	private void setupSideMenu(){
		this.sideMenu=new SideMenu();
		this.sideMenu.setSize(width/4,height);
		this.sideMenu.setLocation(new PVector(width/8,height/2));
		this.sideMenu.setMenuColor(color(104,104,104));
	}

	private void setupEndLabel(){
		this.endLabel=new MenuDisplayFont(40);
		this.endLabel.setLocation(new PVector(width/3.7,height*0.4+75+75/2));
		this.endLabel.setColor(color(100,0,0));
		this.endLabel.setDisplayText("End Game");
	}

	private void setupEndButton(){
		this.endButton=new ButtonWithText("End"){
			@Override
			protected void displayContent(){
				pushMatrix();
				translate(super.location.x-super._width/4,super.location.y);
				strokeWeight(3);
				stroke(100,0,0);
				fill(100,0,0);
				rect(0,0,super._width/6,super._width/6,super._width/40);
				strokeWeight(1);
				popMatrix();
			}
		};
		this.endButton.setLocation(new PVector(width/8,height*0.4+75));
		this.endButton.setSize(width/4,75);
		this.endButton.setMainColor(color(58,58,58));
		this.endButton.setHoverColor(color(145,145,145));
		this.endButton.setContentColor(color(186,186,186));
		this.endButton.updateFont();
		this.endButton.setKeyReleasedTrigger('e');
	}

	private void setupExitButton(){
		this.exitButton=new ButtonWithText("Exit"){
			@Override
			protected void displayContent(){
				float xDist=(super._height/4)*cos(PI/4);
				float yDist=(super._height/4)*sin(PI/4);
				pushMatrix();
				translate(super.location.x-super._width/4,super.location.y);
				strokeWeight(3);
				stroke(255,0,0,100);
				line(-xDist,-yDist,xDist,yDist);
				line(xDist,-yDist,-xDist,yDist);
				strokeWeight(1);
				popMatrix();
			}
		};
		this.exitButton.setLocation(new PVector(width/8,height-75/2));
		this.exitButton.setSize(width/4,75);
		this.exitButton.setMainColor(color(58,58,58));
		this.exitButton.setHoverColor(color(145,145,145));
		this.exitButton.setContentColor(color(186,186,186));
		this.exitButton.updateFont();
		this.exitButton.setKeyReleasedTrigger('x');
	}

	private void setupResumeLabel(){
		this.resumeLabel=new MenuDisplayFont(40);
		this.resumeLabel.setLocation(new PVector(width/3.7,height*0.4+75/2));
		this.resumeLabel.setColor(color(100,0,0));
		this.resumeLabel.setDisplayText("Resume");
	}

	private void setupResumeButton(){
		this.resumeButton=new LevelButton(0);
		this.resumeButton.setLocation(new PVector(width/8,height*0.4));
		this.resumeButton.setSize(width/4,75);
		this.resumeButton.setMainColor(color(58,58,58));
		this.resumeButton.setHoverColor(color(145,145,145));
		this.resumeButton.setContentColor(color(186,186,186));
		this.resumeButton.updateFont();
		this.resumeButton.setAvailable(true);
		this.resumeButton.setKeyReleasedTrigger('p');
	}

	private void setupMenuTitleFont(){
		this.menuTitleFont=new MenuDisplayFont(50);
		this.menuTitleFont.setLocation(new PVector(10,45));
		this.menuTitleFont.setColor(color(255,0,0));
		this.menuTitleFont.setDisplayText("Space\nGame\n2");
	}

	private void setupUpdateComponents(){
		//
	}

	private void setupDisplayComponents(){
		super.addDisplayComponent(BACKGROUND);
		super.addDisplayComponent(this.sideMenu);
		super.addDisplayComponent(this.menuTitleFont);
		super.addDisplayComponent(this.exitButton);
		super.addDisplayComponent(this.resumeButton);
		super.addDisplayComponent(this.endButton);
		super.addDisplayComponent(this.resumeLabel);
		super.addDisplayComponent(this.endLabel);
	}
		
	private void setupResetComponents(){
		super.addResetComponent(this.exitButton);
		super.addResetComponent(this.resumeButton);
		super.addResetComponent(this.endButton);
	}

	private void setupInteractiveComponents(){
		super.addInteractiveComponent(this.exitButton);
		super.addInteractiveComponent(this.resumeButton);
		super.addInteractiveComponent(this.endButton);
	}

	public SideMenu getSideMenu(){
		return this.sideMenu;
	}
	public ButtonWithText getExitButton(){
		return this.exitButton;
	}
	public LevelButton getResumeButton(){
		return this.resumeButton;
	}
	public MenuDisplayFont getMenuTitleFont(){
		return this.menuTitleFont;
	}
	public MenuDisplayFont getResumeLabel(){
		return this.resumeLabel;
	}
	public ButtonWithText getEndButton(){
		return this.endButton;
	}
}
