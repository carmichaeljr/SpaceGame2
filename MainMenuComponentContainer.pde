private class MainMenuComponentContainer extends MenuComponentContainer {
	private LevelButton[] levelButtons;
	private HelpButton keysHelpButton;
	private ButtonWithText resetButton;
	private MenuDisplayFont minTimesDescription;
	private MenuDisplayFont[] minTimes;
	private MenuDisplayFont totalEnemiesKilledDescription;
	private MenuDisplayFont totalEnemiesKilled;
	private MenuDisplayFont wonDescription;

	public MainMenuComponentContainer(){
		super();
		this.levelButtons=new LevelButton[MAX_LEVEL];
		this.minTimes=new MenuDisplayFont[MAX_LEVEL];
		this.setupMinTimesDescription();
		this.setupWonDescription();
		this.setupLevelButtons();
		this.setupLevelMinTimes();
		this.setupTotalEnemiesKilledDescription();
		this.setupTotalEnemiesKilled();
		this.setupResetButton();
		this.setupKeysHelpButton();
		this.setupUpdateComponents();
		this.setupDisplayComponents();
		this.setupResetComponents();
		this.setupInteractiveComponents();
	}

	private void setupLevelButtons(){
		for (int i=0; i<MAX_LEVEL; i++){
			this.levelButtons[i]=new LevelButton(i);
			this.levelButtons[i].setLocation(new PVector(width/8,height*0.4+75*i));
			this.levelButtons[i].setSize(width/4,75);
			this.levelButtons[i].setMainColor(color(58,58,58));
			this.levelButtons[i].setHoverColor(color(145,145,145));
			this.levelButtons[i].setContentColor(color(186,186,186));
			this.levelButtons[i].updateFont();
			this.levelButtons[i].setKeyReleasedTrigger((char)((i+1)+'0'));
		}
	}

	private void setupMinTimesDescription(){
		this.minTimesDescription=new MenuDisplayFont(40);
		this.minTimesDescription.setLocation(new PVector(width/3.7,height*0.4-75/2));
		this.minTimesDescription.setColor(color(100,0,0));
		this.minTimesDescription.setDisplayText("Min times:");
	}

	private void setupLevelMinTimes(){
		for (int i=0; i<MAX_LEVEL; i++){
			this.minTimes[i]=new MenuDisplayFont(40);
			this.minTimes[i].setLocation(new PVector(width/3.7,height*0.4+75*i+75/2));
			this.minTimes[i].setColor(color(100,0,0));
			this.minTimes[i].setDisplayTextFormat("%02d:%02d");
			this.minTimes[i].setDisplayText(0,0);
		}
	}

	private void setupTotalEnemiesKilledDescription(){
		this.totalEnemiesKilledDescription=new MenuDisplayFont(40);
		this.totalEnemiesKilledDescription.setLocation(new PVector(width/3.7,height*0.4+75*3+75/2));
		this.totalEnemiesKilledDescription.setColor(color(100,0,0));
		this.totalEnemiesKilledDescription.setDisplayText("Enemies Killed:");
	}

	private void setupTotalEnemiesKilled(){
		this.totalEnemiesKilled=new MenuDisplayFont(40);
		this.totalEnemiesKilled.setLocation(new PVector(width/3.7,height*0.4+75*4+75/2));
		this.totalEnemiesKilled.setColor(color(100,0,0));
		this.totalEnemiesKilled.setDisplayTextFormat("%d");
		this.totalEnemiesKilled.setDisplayText(0);
	}

	private void setupWonDescription(){
		this.wonDescription=new MenuDisplayFont(50);
		this.wonDescription.setLocation(new PVector(width/3.7,height*0.4-75-75/2));
		this.wonDescription.setColor(color(100,0,0));
		this.wonDescription.setDisplayTextFormat("You: %s");
		this.wonDescription.setDisplayText("");
	}

	private void setupResetButton(){
		this.resetButton=new ButtonWithText("Reset"){
			@Override
			protected void displayContent(){
				pushMatrix();
				translate(super.location.x-super._width/4,super.location.y);
				strokeWeight(3);
				stroke(super.getContentColor());
				noFill();
				arc(0,0,super._width/8,super._width/8,-PI/2,PI);
				line(0,-super._width/16,super._width/32,super._width/32-super._width/16);
				line(0,-super._width/16,super._width/32,-super._width/32-super._width/16);
				strokeWeight(1);
				popMatrix();
			}
		};
		this.resetButton.setLocation(new PVector(width/8,height-75-75/2));
		this.resetButton.setSize(width/4,75);
		this.resetButton.setMainColor(color(58,58,58));
		this.resetButton.setHoverColor(color(145,145,145));
		this.resetButton.setContentColor(color(186,186,186));
		this.resetButton.updateFont();
		//this.resetButton.setKeyReleasedTrigger('x');
	}

	private void setupKeysHelpButton(){
		this.keysHelpButton=new HelpButton();
		this.keysHelpButton.setLocation(new PVector(width-40,40));
		this.keysHelpButton.setSize(50,50);
		this.keysHelpButton.setMainColor(color(58,58,200));
		this.keysHelpButton.setHoverColor(color(145,145,145));
		this.keysHelpButton.setContentColor(color(186,186,255));
		this.keysHelpButton.updateFont();
		this.keysHelpButton.setKeyReleasedTrigger('h');
	}

	private void setupUpdateComponents(){
		//
	}

	private void setupDisplayComponents(){
		super.addDisplayComponent(this.wonDescription);
		super.addDisplayComponent(this.minTimesDescription);
		super.addDisplayComponent(this.totalEnemiesKilledDescription);
		for (int i=0; i<MAX_LEVEL; i++){
			super.addDisplayComponent(this.levelButtons[i]);
			super.addDisplayComponent(this.minTimes[i]);
		}
		super.addDisplayComponent(this.totalEnemiesKilled);
		super.addDisplayComponent(this.keysHelpButton);
		super.addDisplayComponent(this.resetButton);
	}

	private void setupResetComponents(){
		for (int i=0; i<MAX_LEVEL; i++){
			super.addResetComponent(this.levelButtons[i]);
		}
		super.addResetComponent(this.keysHelpButton);
		super.addResetComponent(this.resetButton);
	}

	private void setupInteractiveComponents(){
		for (int i=0; i<MAX_LEVEL; i++){
			super.addInteractiveComponent(this.levelButtons[i]);
		}
		super.addInteractiveComponent(this.keysHelpButton);
		super.addInteractiveComponent(this.resetButton);
	}

	public LevelButton getLevelButton(int index){
		if (index<this.levelButtons.length){
			return this.levelButtons[index];
		}
		return null;
	}
	public LevelButton[] getLevelButtons(){
		return this.levelButtons;
	}
	public ButtonWithText getExitButton(){
		return this.exitButton;
	}
	public MenuDisplayFont getMenuTitleFont(){
		return this.menuTitleFont;
	}
	public MenuDisplayFont getMinTimeFont(int index){
		if (index<this.minTimes.length){
			return this.minTimes[index];
		}
		return null;
	}
	public MenuDisplayFont getTotalEnemiesKilledDescription(){
		return this.totalEnemiesKilledDescription;
	}
	public MenuDisplayFont getTotalEnemiesKilled(){
		return this.totalEnemiesKilled;
	}
	public HelpButton getHelpButton(){
		return this.keysHelpButton;
	}
	public ButtonWithText getResetButton(){
		return this.resetButton;
	}
	public MenuDisplayFont getWonDescription(){
		return this.wonDescription;
	}
}
