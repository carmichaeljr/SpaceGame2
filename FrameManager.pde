private abstract class FrameManager<T extends CrossFrameData> {
	private ArrayList<Frame> managers;
	protected T crossFrameData;
	protected SettingsManager settingsManager;

	public FrameManager(String settingsPath){
		this.managers=new ArrayList<Frame>();
		this.settingsManager=new SettingsManager(settingsPath);
		this.setupCrossFrameData();
		this.populateManagersList();
		for (Frame iterFrame: this.managers){
			if (this.crossFrameData.getActiveFrame().equalsIgnoreCase(iterFrame.getID())){
				iterFrame.start();
			}
		}
	}

	protected abstract void setupCrossFrameData();
	protected abstract void populateManagersList();

	public boolean getExit(){
		return this.crossFrameData.getExit();
	}

	public void setKeyPressed(){
		boolean _break=false;
		for (int i=0; i<this.managers.size() && !_break; i++){
			if (this.managers.get(i).getActive()){
				this.managers.get(i).getKeyboardManager().setKeyPressed(true);
			}
		}
	}

	public void setKeyReleased(){
		boolean _break=false;
		for (int i=0; i<this.managers.size() && !_break; i++){
			if (this.managers.get(i).getActive()){
				this.managers.get(i).getKeyboardManager().setKeyReleased(true);
			}
		}
	}

	public void setMouseReleased(){
		boolean _break=false;
		for (int i=0; i<this.managers.size() && !_break; i++){
			if (this.managers.get(i).getActive()){
				this.managers.get(i).getMouseManager().setMouseReleased(true);
			}
		}
	}

	public void run(){
		this.checkForMenuChange();
		for (Frame iterFrame: this.managers){
			if (this.crossFrameData.getActiveFrame().equalsIgnoreCase(iterFrame.getID())){
				iterFrame.run();
			}
		}
	}

	private void checkForMenuChange(){
		if (!this.crossFrameData.getPreviousFrame().equals("")){
			Frame stopFrame=null;
			Frame startFrame=null;
			for (Frame iterFrame: this.managers){
				if (iterFrame.getID().equalsIgnoreCase(this.crossFrameData.getPreviousFrame())){
					stopFrame=iterFrame;
				} else if (iterFrame.getID().equalsIgnoreCase(this.crossFrameData.getActiveFrame())){
					startFrame=iterFrame;
				}
			}
			if (stopFrame!=null) stopFrame.stop();
			if (startFrame!=null) startFrame.start();
			this.crossFrameData.setPreviousFrame("");
		}
	}

	public void exit(){
		this.crossFrameData.saveChanges();
	}
}
