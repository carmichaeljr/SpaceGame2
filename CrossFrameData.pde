private class CrossFrameData {
	protected SettingsManager settingsManagerRef;
	protected String active;
	protected String previous;
	protected boolean performReset;
	protected boolean _exit;

	public CrossFrameData(SettingsManager settingsManagerRef){
		this.settingsManagerRef=settingsManagerRef;
		this.active=settingsManagerRef.getSetting("active");
		this.previous=new String();
		this.performReset=false;
		this._exit=false;
	}

	public void switchMenu(String nextMenuID){
		this.previous=this.active;
		this.active=nextMenuID;
	}
	public String getActiveFrame(){
		return this.active;
	}
	public String getPreviousFrame(){
		return this.previous;
	}
	public void setPreviousFrame(String previousFrame){
		this.previous=previousFrame;
	}

	public void setPerformReset(boolean performReset){
		this.performReset=performReset;
	}
	public boolean getPerformReset(){
		return this.performReset;
	}

	public void setExit(boolean _exit){
		this._exit=_exit;
	}
	public boolean getExit(){
		return this._exit;
	}

	public void saveChanges(){
		this.settingsManagerRef.saveSetting("active",this.active);
	}
}
