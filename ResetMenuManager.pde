private class ResetMenuManager extends Frame<GameCrossFrameData> {
	private ResetComponentContainer resetMenuComponentContainer;
	private ComponentManager<ResetComponentContainer> resetMenuComponentManager;
	private MouseManager<ResetComponentContainer> resetMenuComponentMouseManager;
	private KeyboardManager<ResetComponentContainer> resetMenuComponentKeyboardManager;

	public ResetMenuManager(GameCrossFrameData crossFrameData){
		super("resetMenu",crossFrameData);
		this.resetMenuComponentContainer=new ResetComponentContainer();
		this.resetMenuComponentManager=new ComponentManager<ResetComponentContainer>(this.resetMenuComponentContainer);
		this.resetMenuComponentMouseManager=new MouseManager<ResetComponentContainer>(this.resetMenuComponentContainer);
		this.resetMenuComponentKeyboardManager=new KeyboardManager<ResetComponentContainer>(this.resetMenuComponentContainer);
		this.setButtonAction("exit",this);
		this.setButtonAction("yes",this);
		this.setButtonAction("no",this);
	}

	@Override
	public KeyboardManager getKeyboardManager(){
		return this.resetMenuComponentKeyboardManager;
	}
	@Override
	public MouseManager getMouseManager(){
		return this.resetMenuComponentMouseManager;
	}
	@Override
	public ComponentManager getComponentManager(){
		return this.resetMenuComponentManager;
	}

	public void setButtonAction(String id, ButtonActionInterface buttonAction){
		switch (id){
			case "exit": this.resetMenuComponentContainer.getExitButton().setButtonAction(buttonAction); break;
			case "yes": this.resetMenuComponentContainer.getYesButton().setButtonAction(buttonAction); break;
			case "no": this.resetMenuComponentContainer.getNoButton().setButtonAction(buttonAction); break;
			default: break;
		}
	}

	public void performButtonAction(String ... args){
		if (args.length>0){
			switch (args[0].toLowerCase()){
				case "exit": super.crossFrameData.setExit(true); break;
				case "yes": super.crossFrameData.reset();
				case "no": super.crossFrameData.switchMenu("mainMenu"); break;
				default: break;
			}
		}
	}
}
