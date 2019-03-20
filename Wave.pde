class Wave {
	private float amplitude;
	private float period;
	private float startAngle;
	
	public Wave(){
		this.amplitude=0;
		this.period=0;
		this.startAngle=0;
	}
	
	public void setAmplitude(float amplitude){
		this.amplitude=amplitude;
	}
	public void setPeriod(float period){
		this.period=period;
	}
	public void setStartAngle(float startAngle){
		this.startAngle=startAngle;
	}
	
	public void update(){
		this.startAngle+=0.2;
	}
	
	public float getYValue(float x){
		return this.amplitude*sin(this.period*x);
	}
	
	public void display(){
		noFill();
		beginShape();
		float angle=this.startAngle;
		for(int i=0; i<width; i++){
			float y=this.getYValue(angle);
			vertex(i,y+this.amplitude);
			angle+=1;
		}
		endShape();
	}
}
