private class GameArea {
	private PVector size;

	public GameArea(PVector size){
		this.size=size.get();
	}

	public PVector getSize(){
		return this.size;
	}
	public float getSizeX(){
		return this.size.x;
	}
	public float getSizeY(){
		return this.size.y;
	}

	public void setSize(PVector size){
		this.size=size.get();
	}
}
