private class HelpMenuManager extends Frame<GameCrossFrameData> {
	private HelpMenuComponentContainer helpMenuComponentContainer;
	private ComponentManager<HelpMenuComponentContainer> helpMenuComponentManager;
	private MouseManager<HelpMenuComponentContainer> helpMenuComponentMouseManager;
	private KeyboardManager<HelpMenuComponentContainer> helpMenuComponentKeyboardManager;

	public HelpMenuManager(GameCrossFrameData crossFrameData){
		super("helpMenu",crossFrameData);
		this.helpMenuComponentContainer=new HelpMenuComponentContainer();
		this.helpMenuComponentManager=new ComponentManager<HelpMenuComponentContainer>(this.helpMenuComponentContainer);
		this.helpMenuComponentMouseManager=new MouseManager<HelpMenuComponentContainer>(this.helpMenuComponentContainer);
		this.helpMenuComponentKeyboardManager=new KeyboardManager<HelpMenuComponentContainer>(this.helpMenuComponentContainer);
		this.setButtonAction("exit",this);
		this.setButtonAction("back",this);
	}

	@Override
	public KeyboardManager getKeyboardManager(){
		return this.helpMenuComponentKeyboardManager;
	}
	@Override
	public MouseManager getMouseManager(){
		return this.helpMenuComponentMouseManager;
	}
	@Override
	public ComponentManager getComponentManager(){
		return this.helpMenuComponentManager;
	}

	public void setButtonAction(String id, ButtonActionInterface buttonAction){
		switch (id){
			case "exit": this.helpMenuComponentContainer.getExitButton().setButtonAction(buttonAction); break;
			case "back": this.helpMenuComponentContainer.getBackButton().setButtonAction(buttonAction); break;
			default: break;
		}
	}

	public void performButtonAction(String ... args){
		if (args.length>0){
			switch (args[0].toLowerCase()){
				case "exit": super.crossFrameData.setExit(true); break;
				case "back": super.crossFrameData.switchMenu("mainMenu"); break;
				default: break;
			}
		}
	}
}
