private class Ground extends ScrollerPane implements 
	CollisionDetection,UpdateInterface,DisplayInterface,DebugDisplayInterface {
	private ArrayList<GroundWave> groundWaves;
	private float length;
	
	public Ground(){
		super();
		this.groundWaves=new ArrayList<GroundWave>();
		this.length=GAME_AREA.getSizeX();
		this.groundWaves.add(new GroundWave(random(0,1000),super.location.y));
	}

	public float getLength(){
		return this.length;
	}

	@Override
	public void setLocation(PVector location){
		super.setLocation(location);
		for (int i=0; i<this.groundWaves.size(); i++){
			float distFromFront=(i*(super.location.y-height/2))/(i+1);
			this.groundWaves.get(i).setScreenHeight(super.location.y-distFromFront);
		}
	}

	public void setGroundGranularity(float newGG){
		for (GroundWave iterWave: this.groundWaves){
			iterWave.setGroundGranularity(newGG);
		}
	}

	public void setNumGroundWaves(int numGW){
		int origSize=this.groundWaves.size();
		if (numGW>this.groundWaves.size()){
			for (int i=0; i<numGW-origSize; i++){
				float distFromFront=((i+origSize-1)*(super.location.y-height/2))/(i+origSize);
				GroundWave temp=new GroundWave(random(0,1000),super.location.y-distFromFront);
				temp.setGroundGranularity(this.groundWaves.get(0).getGroundGranularity());
				this.groundWaves.add(temp);
			}
		} else {
			for (int i=this.groundWaves.size(); i>numGW; i--){
				this.groundWaves.remove(i);
			}
		}
	}
	public float getNumGroundWaves(){
		return this.groundWaves.size();
	}
	
	public void appendWave(float amplitude, float period){
		for (int i=0; i<this.groundWaves.size(); i++){
			this.groundWaves.get(i).appendWave(amplitude/(i+1),period*(i+1));
		}
	}
	
	public float getGroundCoordinate(float xCoord){
		return this.groundWaves.get(0).getGroundCoordinate(xCoord);
	}
	
	@Override
	public void update(){
	      super.update();
	      if (super.location.x>width/2){
	      	super.location.x=width/2;
	      	super.velocity.x=0;
	      } else if (super.location.x+this.length<width/2){
	      	super.location.x=(width/2)-this.length;
	      	super.velocity.x=0;
	      }
	}
	
	@Override
	public void display(){
		this.displayGround();
		this.displayEOWMarks();
	}


	private void displayGround(){
		for (int i=this.groundWaves.size()-1; i>=0; i--){
			pushMatrix();
			translate(super.location.x,this.groundWaves.get(i).getScreenHeight());
			noStroke();
			int translationDiff=int((i*super.location.x)/(i+1));
			if (i==0){
				fill(150);
			} else {
				fill(map(i,0,this.groundWaves.size(),100,10));
			}
			beginShape();
			float angle=this.groundWaves.get(i).getStartAngle()+translationDiff-super.location.x;
			int endingValue=(int)min(GAME_AREA.getSizeX(),-super.location.x+width);
			int startingValue=(int)max(0,-super.location.x);
			if (startingValue==0){
				angle+=super.location.x;
			}
			for (int j=startingValue; j<endingValue; j+=5){
				float y=this.groundWaves.get(i).getYValueSum(angle);
				vertex(j,y);
				angle+=5;
			}
			vertex(GAME_AREA.getSizeX(),height);
			vertex(0,height);
			endShape();
			popMatrix();
		}
	}

	private void displayEOWMarks(){
		for (int i=0; i<10; i++){
			stroke(255-(i*25),0,0);
			line(this.location.x+i,0,this.location.x+i,height);
			line(this.location.x+this.length-i,0,this.location.x+this.length-i,height);
		}
		fill(255,0,0);
		textSize(30);
		pushMatrix();
		translate(super.location.x,(height/2)+(textWidth("End of World")/2));
		rotate(-HALF_PI);
		text("End of World",0,0);
		popMatrix();
		pushMatrix();
		translate(super.location.x+this.length,(height/2)-(textWidth("End of World")/2));
		rotate(HALF_PI);
		text("End of World",0,0);
		popMatrix();
	}

	@Override
	public void displayDebug(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		stroke(255,10,10);
		float angle=this.groundWaves.get(0).getStartAngle();
		for (int i=0; i<GAME_AREA.getSizeX(); i+=2){
			point(i,this.groundWaves.get(0).getYValueSum(angle)-70);
			angle+=2;
		}
		popMatrix();
	}

	@Override
	public boolean collided(Mover obj){
		float groundY=this.getGroundCoordinate(obj.getLocation().x);
		float objectY=obj.getLocation().y+obj.getMass()/2;
		if (objectY>=groundY){
			return true;
		}
		return false;
	}

	@Override
	public void performCollisionAction(String ... otherID){
		if (otherID[0].equalsIgnoreCase("player")){
			super.velocity.set(0,0);
		}
	}
}
