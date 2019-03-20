private class GameCrossFrameData extends CrossFrameData {
	private int currentLevel;
	private int activeLevel;
	private long totalEnemiesKilled;
	private int[] minTimes;
	private boolean resetRound;
	private String wonDescription;

	public GameCrossFrameData(SettingsManager settingsManagerRef){
		super(settingsManagerRef);
		this.currentLevel=Integer.parseInt(super.settingsManagerRef.getSetting("currentLevel"));
		this.totalEnemiesKilled=Long.parseLong(super.settingsManagerRef.getSetting("totalEnemiesKilled"));
		this.wonDescription="";
		this.activeLevel=0;
		this.resetRound=false;
		this.minTimes=new int[MAX_LEVEL];
		String[] temp=split(super.settingsManagerRef.getSetting("minTimes"),",");
		for (int i=0; i<MAX_LEVEL; i++){
			this.minTimes[i]=Integer.parseInt(temp[i]);
		}
		if (DEBUG){
			this.printDebug();
		}
	}

	private void printDebug(){
		println("currentLevel: "+this.currentLevel);
		println("totalEnemiesKilled: "+this.totalEnemiesKilled);
		for (int i=0; i<MAX_LEVEL; i++){
			println("minTime "+i+": "+this.minTimes[i]);
		}
		println("active: "+this.active);
		println("previous: "+this.previous);
		println("exit: "+this._exit);
	}

	public void incrementCurrentLevel(){
		if (++this.currentLevel>=MAX_LEVEL){
			this.currentLevel--;
		}
	}
	public int getCurrentLevel(){
		return this.currentLevel;
	}

	public void setActiveLevel(int activeLevel){
		if (activeLevel<MAX_LEVEL && activeLevel<=this.currentLevel){
			this.activeLevel=activeLevel;
		}
	}
	public int getActiveLevel(){
		return this.activeLevel;
	}

	public void incrementTotalEnemiesKilled(int increment){
		this.totalEnemiesKilled+=increment;
	}
	public long getTotalEnemiesKilled(){
		return this.totalEnemiesKilled;
	}

	public void setMinTime(int level, int timeInSeconds){
		if (level<MAX_LEVEL && 
			(timeInSeconds<this.minTimes[level] || this.minTimes[level]==0)){
			this.minTimes[level]=timeInSeconds;
		}
	}
	public void setMinTime(int timeInSeconds){
		if (timeInSeconds<this.minTimes[this.activeLevel] || this.minTimes[this.activeLevel]==0){
			this.minTimes[this.activeLevel]=timeInSeconds;
		}
	}
	public int getMinTime(int level){
		if (level<MAX_LEVEL){
			return this.minTimes[level];
		}
		return -1;
	}

	public boolean getResetRound(){
		return this.resetRound;
	}
	public void setResetRound(boolean reset){
		this.resetRound=reset;
	}

	public String getWonDescription(){
		return this.wonDescription;
	}
	public void setWonDesctiprion(String winStatus){
		this.wonDescription=winStatus;
	}

	public void reset(){
		this.resetRound=false;
		this.currentLevel=0;
		this.activeLevel=0;
		this.totalEnemiesKilled=0;
		this.wonDescription="";
		for (int i=0; i<MAX_LEVEL; i++){
			this.minTimes[i]=0;
		}
	}

	@Override
	public void saveChanges(){
		super.saveChanges();
		HashMap<String,String> temp=new HashMap<String,String>();
		temp.put("currentLevel",String.format("%d",this.currentLevel));
		temp.put("totalEnemiesKilled",String.format("%d",this.totalEnemiesKilled));
		temp.put("minTimes",String.format("%d,%d,%d",this.minTimes[0],this.minTimes[1],this.minTimes[2]));
		super.settingsManagerRef.saveSettings(temp);
	}
}
