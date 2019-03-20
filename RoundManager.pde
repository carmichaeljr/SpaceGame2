private class RoundManager extends Frame<GameCrossFrameData> {
	private RoundComponentContainer roundComponentContainer;
	private RoundComponentManager roundComponentManager;
	private MouseManager<RoundComponentContainer> roundComponentMouseManager;
	private RoundComponentKeyboardManager roundComponentKeyboardManager;
	private RoundComponentCollisionManager roundComponentCollisionManager;
	private HashMap<String,Integer> roundData;
	private float startTime;
	
	public RoundManager(GameCrossFrameData crossFrameData){
		super("round",crossFrameData);
		this.roundComponentContainer=new RoundComponentContainer();
		this.roundComponentManager=new RoundComponentManager(this.roundComponentContainer);
		this.roundComponentMouseManager=new MouseManager<RoundComponentContainer>(this.roundComponentContainer);
		this.roundComponentKeyboardManager=new RoundComponentKeyboardManager(this.roundComponentContainer);
		this.roundComponentCollisionManager=new RoundComponentCollisionManager(this.roundComponentContainer);
		this.roundData=new HashMap<String,Integer>();
		this.setupRoundData();
		this.roundData.put("gameover",1);
		this.startTime=0;
		this.setButtonAction("pause",this);
	}

	@Override
	public MouseManager getMouseManager(){
		return this.roundComponentMouseManager;
	}
	@Override
	public KeyboardManager getKeyboardManager(){
		return (KeyboardManager)this.roundComponentKeyboardManager;
	}
	@Override
	public ComponentManager getComponentManager(){
		return this.roundComponentManager;
	}

	public void setButtonAction(String buttonName, ButtonActionInterface buttonAction){
		switch(buttonName.toLowerCase()){
			case "pause": this.roundComponentContainer.getPauseButton().setButtonAction(buttonAction); break;
			default: break;
		}
	}

	private void setupRoundData(){
		this.roundData.put("gameover",0);
		this.roundData.put("win",0);
		this.roundData.put("enemieskilled",0);
		this.roundData.put("time",0);
	}

	public void start(){
		if (this.roundData.get("gameover")==1 || super.crossFrameData.getResetRound()){
			this.roundComponentContainer.initilize();
			this.setupRoundData();
			this.setLevelValues();
			super.crossFrameData.setResetRound(false);
		}
		this.startTime=millis()-this.roundData.get("time")*1000;
		this.roundComponentKeyboardManager.start();
		this.roundComponentMouseManager.start();
		this.active=true;
	}

	private void setLevelValues(){
		int level=super.crossFrameData.getActiveLevel();
		this.roundComponentContainer.getOponents().setNumOponents(10*((level+1)%3)+10);
		this.roundComponentContainer.getOponents().setForceFieldLevel(level);
		this.roundComponentContainer.getOponents().setBurstTime(abs(MAX_LEVEL-level)*0.1);
		if (level+1==MAX_LEVEL){
			this.roundComponentContainer.getBoss().setActive(true);
			this.roundComponentContainer.getBoss().setForceFieldLevel(0);
			this.roundComponentContainer.getBoss().setBurstTime(abs(MAX_LEVEL-level)*0.1);
		} else {
			this.roundComponentContainer.getBoss().setActive(false);
			this.roundComponentContainer.removeUpdateComponent(this.roundComponentContainer.getBoss());
			this.roundComponentContainer.removeDisplayComponent(this.roundComponentContainer.getBoss());
		}
	}

	@Override
	public void update(){
		super.update();
		this.roundComponentCollisionManager.update();
		this.updateRoundData();
		this.updateCrossFrameData();
	}

	private void updateRoundData(){
		int tempDeathCount=this.roundComponentContainer.getOponents().getDeathCount();
		boolean tempWin=(this.roundComponentContainer.getOponents().getNumOponents()==0)? true: false;
		if (this.roundComponentContainer.getBoss().getActive()){
			tempWin&=(this.roundComponentContainer.getBoss().getNumOponents()==0)? true: false;
		}
		boolean tempGameOver=tempWin ||
			this.roundComponentContainer.getPlayer().getCrashed();
		this.roundData.put("win",tempWin? 1: 0);
		this.roundData.put("gameover",tempGameOver? 1: 0);
		this.roundData.put("enemieskilled",tempDeathCount);
		if ((millis()-this.roundData.get("time"))/1000>1){
			int time=int((millis()-this.startTime)/1000);
			this.roundData.put("time",time);
			this.roundComponentContainer.getTimerFont().setDisplayText(time);
		}
	}

	private void updateCrossFrameData(){
		if (this.roundData.get("gameover")==1){
			super.crossFrameData.setWonDesctiprion("Lost");
			super.crossFrameData.incrementTotalEnemiesKilled(this.roundData.get("enemieskilled"));
			if (this.roundData.get("win")==1){
				if (super.crossFrameData.getActiveLevel()==super.crossFrameData.getCurrentLevel()){
					super.crossFrameData.incrementCurrentLevel();
				}
				super.crossFrameData.setWonDesctiprion("WON");
				super.crossFrameData.setMinTime((int)this.roundData.get("time"));
			}
			super.crossFrameData.switchMenu("mainMenu");
		}
	}

	@Override
	public void stop(){
		super.stop();
		super.display();
		BACKGROUND.setBackground();
	}

	public void performButtonAction(String ... args){
		if (args.length>0){
			switch (args[0].toLowerCase()){
				case "pause": super.crossFrameData.switchMenu("pauseMenu"); break;
				default: break;
			}
		}
	}
}
