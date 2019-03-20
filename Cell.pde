private class Cell {
	protected int generations;
	protected float x,y;
	protected float width;
	protected float state;
	protected float previousState;

	public Cell(){
		this.state=0;
		this.width=0;
		this.x=0;
		this.y=0;
		this.previousState=0;
		this.generations=0;
	}

	public int getGenerations(){
		return this.generations;
	}
	public void setGenerations(int gen){
		this.generations=gen;
	}

	public float getState(){
		return this.state;
	}
	public void setState(float state){
		//this.previousState=this.state;
		this.state=constrain(state,0,1);
	}

	public float getPreviousState(){
		return this.previousState;
	}

	public void setWidth(float width){
		this.width=width;
	}
	
	public void setPosition(PVector position){
		this.x=position.x;
		this.y=position.y;
	}

	public void update(){
		this.previousState=this.state;
		if (this.state>0){
			this.generations++;
		} else {
			this.generations=0;
		}
	}

	public void display(){
		fill(0,map(this.generations,0,20,0,255),0);
		stroke(0,map(this.generations,0,20,0,255),0);
		//fill(0,map(this.state,0,1,0,255),0);
		rect(this.x,this.y,this.width,this.width);
	}
}
