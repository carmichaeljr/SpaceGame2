private class PauseMenuManager extends Frame<GameCrossFrameData> {
	private PauseMenuComponentContainer pauseMenuComponentContainer;
	private ComponentManager<PauseMenuComponentContainer> pauseMenuComponentManager;
	private MouseManager<PauseMenuComponentContainer> pauseMenuComponentMouseManager;
	private KeyboardManager<PauseMenuComponentContainer> pauseMenuComponentKeyboardManager;

	public PauseMenuManager(GameCrossFrameData crossFrameData){
		super("pauseMenu",crossFrameData);
		this.pauseMenuComponentContainer=new PauseMenuComponentContainer();
		this.pauseMenuComponentManager=new ComponentManager<PauseMenuComponentContainer>(this.pauseMenuComponentContainer);
		this.pauseMenuComponentMouseManager=new MouseManager<PauseMenuComponentContainer>(this.pauseMenuComponentContainer);
		this.pauseMenuComponentKeyboardManager=new KeyboardManager<PauseMenuComponentContainer>(this.pauseMenuComponentContainer);
		this.setButtonAction("exit",this);
		this.setButtonAction("play",this);
		this.setButtonAction("end",this);
	}

	@Override
	public KeyboardManager getKeyboardManager(){
		return this.pauseMenuComponentKeyboardManager;
	}
	@Override
	public MouseManager getMouseManager(){
		return this.pauseMenuComponentMouseManager;
	}
	@Override
	public ComponentManager getComponentManager(){
		return this.pauseMenuComponentManager;
	}

	private void updateResumeButtonLevel(int level){
		this.pauseMenuComponentContainer.getResumeButton().setLevel(level);
	}

	public void setButtonAction(String id, ButtonActionInterface buttonAction){
		switch (id){
			case "exit": this.pauseMenuComponentContainer.getExitButton().setButtonAction(buttonAction); break;
			case "play": this.pauseMenuComponentContainer.getResumeButton().setButtonAction(buttonAction); break;
			case "end": this.pauseMenuComponentContainer.getEndButton().setButtonAction(buttonAction); break;
			default: break;
		}
	}

	@Override
	public void start(){
		this.updateResumeButtonLevel(super.crossFrameData.getActiveLevel());
		super.start();
	}

	public void performButtonAction(String ... args){
		if (args.length>0){
			switch(args[0].toLowerCase()){
				case "exit": super.crossFrameData.setExit(true); break;
				case "play": super.crossFrameData.setActiveLevel(Integer.parseInt(args[1]));
					     super.crossFrameData.switchMenu("round"); break;
				case "end":  super.crossFrameData.setResetRound(true);
					     super.crossFrameData.setWonDesctiprion("Gave Up");
					     super.crossFrameData.switchMenu("mainMenu"); break;
				default: break;
			}
		}
	}
}
