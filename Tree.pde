private class Tree extends Mover {
	private ArrayList<Branch> branches;
	private float noiseX;
	private float noiseY;
	private float theta;
	private float len;
	private float maxLen;
	private float growthRate;

	public Tree(float len, float theta){
		super();
		this.len=len;
		this.theta=theta;
		this.maxLen=height/4;
		this.growthRate=0.01;
		this.noiseX=random(0,1000);
		this.noiseY=random(0,1000);
		this.branches=new ArrayList<Branch>();
	}

	public void setMaxLen(float maxLen){
		this.maxLen=maxLen;
	}

	public void setGrowthRate(float newGR){
		this.growthRate=newGR;
	}

	private void createTree(){
		this.branches.add(new Branch(new PVector(super.location.x,super.location.y),-PI/2,this.len));
		float piDivisor=map(len,30,2,30,3);
		float temp=map(noise(this.noiseX,this.noiseY),0,1,-PI/piDivisor,PI/piDivisor);
		this.branch(super.location.x,super.location.y-this.len,3*HALF_PI+theta+temp,this.len/2,this.noiseX,this.noiseY);
		temp=map(noise(this.noiseX+100,this.noiseY),0,1,-PI/piDivisor,PI/piDivisor);
		this.branch(super.location.x,super.location.y-this.len,3*HALF_PI-theta-temp,this.len/2,
				this.noiseX+100,this.noiseY);
	}

	private void branch(float x, float y, float theta, float len, float noiseX, float noiseY){
		noiseX+=0.5;
		this.branches.add(new Branch(new PVector(x,y),theta,len));
		if (len>2){
			noiseY+=0.1;
			float piDivisor=map(len,30,2,10,1.5);
			float temp=map(noise(noiseX,noiseY),0,1,-PI/piDivisor,PI/piDivisor);
			branch(len*cos(theta)+x,len*sin(theta)+y,theta+this.theta+temp,len*0.66,noiseX,noiseY);
			noiseY+=0.1;
			temp=map(noise(noiseX,noiseY),0,1,-PI/piDivisor,PI/piDivisor);
			branch(len*cos(theta)+x,len*sin(theta)+y,theta-this.theta+temp,len*0.66,noiseX,noiseY);
		}
	}

	public void update(){
		super.update();
		this.branches.clear();
		this.createTree();
		this.noiseX+=0.01;
		this.noiseY+=0.01;
		this.len=constrain(this.len+this.growthRate,0,this.maxLen);
	}

	public void display(){
		for (Branch iterBranch: this.branches){
			iterBranch.display();
		}
	}
}

private class Branch {
	private PVector start;
	private float theta;
	private float len;

	public Branch(PVector start, float theta, float len){
		this.start=start;
		this.theta=theta;
		this.len=len;
	}

	//public PVector getEnd(){

	//}

	public void display(){
		strokeWeight(map(this.len,60,2,8,1));
		line(this.start.x,this.start.y,this.len*cos(this.theta)+this.start.x,this.len*sin(this.theta)+this.start.y);
	}
}
