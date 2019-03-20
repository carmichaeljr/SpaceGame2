private class MainMenuManager extends Frame<GameCrossFrameData> {
	private MainMenuComponentContainer menuComponentContainer;
	private ComponentManager<MainMenuComponentContainer> menuComponentManager;
	private MouseManager<MainMenuComponentContainer> menuComponentMouseManager;
	private KeyboardManager<MainMenuComponentContainer> menuComponentKeyboardManager;

	public MainMenuManager(GameCrossFrameData crossFrameData){
		super("mainMenu",crossFrameData);
		this.menuComponentContainer=new MainMenuComponentContainer();
		this.menuComponentManager=new ComponentManager<MainMenuComponentContainer>(this.menuComponentContainer);
		this.menuComponentMouseManager=new MouseManager<MainMenuComponentContainer>(this.menuComponentContainer);
		this.menuComponentKeyboardManager=new KeyboardManager<MainMenuComponentContainer>(this.menuComponentContainer);
		this.setButtonAction("play",this);
		this.setButtonAction("exit",this);
		this.setButtonAction("help",this);
		this.setButtonAction("reset",this);
	}

	@Override
	public KeyboardManager getKeyboardManager(){
		return this.menuComponentKeyboardManager;
	}
	@Override
	public MouseManager getMouseManager(){
		return this.menuComponentMouseManager;
	}
	@Override
	public ComponentManager getComponentManager(){
		return this.menuComponentManager;
	}

	private void setButtonAction(String buttonName, ButtonActionInterface buttonAction){
		switch (buttonName.toLowerCase()){
			case "play": this.menuComponentContainer.getLevelButton(0).setButtonAction(buttonAction); 
				     this.menuComponentContainer.getLevelButton(1).setButtonAction(buttonAction);
				     this.menuComponentContainer.getLevelButton(2).setButtonAction(buttonAction); break;
			case "exit": this.menuComponentContainer.getExitButton().setButtonAction(buttonAction); break;
			case "help": this.menuComponentContainer.getHelpButton().setButtonAction(buttonAction); break;
			case "reset": this.menuComponentContainer.getResetButton().setButtonAction(buttonAction); break;
			default: break;
		}
	}

	@Override
	public void start(){
		this.activateLevelButtons(super.crossFrameData.getCurrentLevel());
		for (int i=0; i<MAX_LEVEL; i++){
			this.updateMinTime(i,super.crossFrameData.getMinTime(i));
		}
		this.updateTotalEnemiesKilled(super.crossFrameData.getTotalEnemiesKilled());
		this.updateWonDescription();
		super.start();
	}

	private void activateLevelButtons(int currentLevel){
		LevelButton[] levelButtonsRef=this.menuComponentContainer.getLevelButtons();
		for (int i=0; i<MAX_LEVEL; i++){
			if (i<currentLevel+1){
				levelButtonsRef[i].setAvailable(true);
			} else {
				levelButtonsRef[i].setAvailable(false);
			}
		}
	}
	private void updateMinTime(int currentLevel, int timeInSeconds){
		if (currentLevel<MAX_LEVEL){
			MenuDisplayFont temp=this.menuComponentContainer.getMinTimeFont(currentLevel);
			temp.setDisplayText(timeInSeconds/60,timeInSeconds%60);
		}
	}
	private void updateTotalEnemiesKilled(long totalEnemiesKilled){
		this.menuComponentContainer.getTotalEnemiesKilled().setDisplayText(totalEnemiesKilled);
	}

	public void updateWonDescription(){
		this.menuComponentContainer.getWonDescription().setDisplayText(
			super.crossFrameData.getWonDescription());
	}

	@Override
	public void performButtonAction(String ... args){
		if (args.length>0){
			switch (args[0].toLowerCase()){
				case "play": super.crossFrameData.setActiveLevel(Integer.parseInt(args[1]));
					     super.crossFrameData.switchMenu("round"); break;
				case "exit": super.crossFrameData.setExit(true); break;
				case "help": super.crossFrameData.switchMenu("helpMenu"); break;
				case "reset":super.crossFrameData.switchMenu("resetMenu"); break; 
				default: break;
			}
		}
	}
}
