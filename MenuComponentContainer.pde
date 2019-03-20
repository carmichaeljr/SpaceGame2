private class MenuComponentContainer extends ComponentContainer {
	protected SideMenu sideMenu;
	protected ButtonWithText exitButton;
	protected MenuDisplayFont menuTitleFont;

	public MenuComponentContainer(){
		super();
		this.setupSideMenu();
		this.setupMenuTitleFont();
		this.setupExitButton();
		super.addDisplayComponent(BACKGROUND);
		super.addDisplayComponent(this.sideMenu);
		super.addDisplayComponent(this.menuTitleFont);
		super.addDisplayComponent(this.exitButton);
		super.addResetComponent(this.exitButton);
		super.addInteractiveComponent(this.exitButton);
	}

	private void setupSideMenu(){
		this.sideMenu=new SideMenu();
		this.sideMenu.setSize(width/4,height);
		this.sideMenu.setLocation(new PVector(width/8,height/2));
		this.sideMenu.setMenuColor(color(104,104,104));
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

	private void setupMenuTitleFont(){
		this.menuTitleFont=new MenuDisplayFont(50);
		this.menuTitleFont.setLocation(new PVector(10,45));
		this.menuTitleFont.setColor(color(255,0,0));
		this.menuTitleFont.setDisplayText("Space\nGame\n2");
	}
}
