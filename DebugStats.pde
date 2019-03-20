private class DebugStats {
	private boolean frameDisplay;

	public DebugStats(){
		this.frameDisplay=false;
	}

	public void setFrameRate(boolean frameDisplay){
		this.frameDisplay=frameDisplay;
	}
	public boolean getFrameRate(){
		return this.frameDisplay;
	}

	public void display(){
		if (DEBUG){
			textSize(12);
			fill(200);
			stroke(200);
			rect(width/2,10,width,20);
			fill(0);
			text(String.format("Frame Rate: %.2f |",frameRate),5,19);
		} else if (this.frameDisplay){
			textSize(12);
			fill(255);
			text(String.format("Frame Rate: %.2f",frameRate),5,19);
		}
	}
}
