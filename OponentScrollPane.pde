private class Oponents extends ScrollerPane implements 
	UpdateInterface,DisplayInterface,DebugDisplayInterface {
	private ArrayList<Oponent> oponents;
	private FlowField flowFieldRef;
	private Mover playerRef;
	private Ground groundRef;
	private Bullets bulletsRef;
	private int deathCount;
	private int startNum;

	public Oponents(int numOponents){
		this.deathCount=0;
		this.startNum=numOponents;
		this.oponents=new ArrayList<Oponent>();
		for (int i=0; i<numOponents; i++){
			this.addOponent();
		}
	}

	public int getStartNumOponents(){
		return this.startNum;
	}

	public int getDeathCount(){
		return this.deathCount;
	}
	public void incrementDeathCount(){
		this.deathCount++;
	}

	public FlowField getFlowField(){
		return this.flowFieldRef;
	}
	public void setFlowFieldRef(FlowField flowFieldRef){
		this.flowFieldRef=flowFieldRef;
	}

	public Mover getPlayerRef(){
		return this.playerRef;
	}
	public void setPlayerRef(Mover playerRef){
		this.playerRef=playerRef;
	}

	public void setGroundRef(Ground groundRef){
		this.groundRef=groundRef;
	}
	public Ground getGroundRef(){
		return this.groundRef;
	}

	public void setBulletsRef(Bullets bullets){
		this.bulletsRef=bullets;
	}
	public Bullets getBulletsRef(){
		return this.bulletsRef;
	}

	public ArrayList<Oponent> getOponents(){
		return this.oponents;
	}

	public void setNumOponents(int numOponents){
		if (this.oponents.size()>numOponents){
			for (int i=this.oponents.size()-1; i>=numOponents; i--){
				this.oponents.remove(i);
			}
		} else if (this.oponents.size()<numOponents){
			int diff=numOponents-this.oponents.size();
			for (int i=0; i<diff; i++){
				this.addOponent();
			}
		}
		this.startNum=numOponents;
	}
	public int getNumOponents(){
		return this.oponents.size();
	}

	public void setForceFieldLevel(int level){
		for (Oponent iterOponent: this.oponents){
			iterOponent.getForceField().setEffectiveness((level+1)*255/MAX_LEVEL);
		}
	}

	public void setBurstTime(float time){
		for (Oponent iterOponent: this.oponents){
			iterOponent.setShotInterval(time);
		}
	}

	private void addOponent(){
		Oponent temp=new Oponent();
		temp.setMass(40);
		temp.setLocation(new PVector(random(width,GAME_AREA.getSizeX()),random(0,GAME_AREA.getSizeY()/2)));
		temp.getForceField().setColor(color(255,148,0));
		temp.getForceField().setDincrement(255/3);
		this.oponents.add(temp);
	}

	@Override
	public void update(){
		super.update();
		Iterator<Oponent> system=this.oponents.iterator();
		while (system.hasNext()){
			Oponent temp=system.next();
			if (!temp.isDead()){
				this.applyOponentForces(temp);
				this.checkForOponentShot(temp);
				temp.update();
			} else {
				system.remove();
				this.deathCount++;
			}
		}
	}

	private void applyOponentForces(Oponent oponent){
		if (!oponent.getCrashed()){
			PVector flowFieldForce=oponent.getFollowForce(this.flowFieldRef);
			//PVector seekForce=oponent.getSeekForce(this.playerRef.getLocation());
			//PVector separateForce=temp.getSeparateForce(this.oponents);
			PVector groundAvoidForce=this.getGroundAvoidanceForce(oponent);
			oponent.applyForce(flowFieldForce);
			//temp.applyForce(separateForce);
			//temp.applyForce(seekForce.mult(0.5));
			oponent.applyForce(groundAvoidForce.mult(5));
		} else {
			oponent.applyForce(new PVector(0,2));
		}
	}

	private void checkForOponentShot(Oponent oponent){
		float distance=dist(oponent.getLocation().x,oponent.getLocation().y,
				    this.playerRef.getLocation().x,this.playerRef.getLocation().y);
		if (!oponent.getCrashed() && oponent.canShoot() && distance<200 && this.bulletsRef!=null){
			float theta=atan2(this.playerRef.getLocation().y-oponent.getLocation().y,
					  this.playerRef.getLocation().x-oponent.getLocation().x);
			this.bulletsRef.addBullet(oponent.getLocation(),-theta+HALF_PI);//+random(-PI/10,PI/10));
			oponent.resetShootTimer();
		}
	}

	@Override
	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		for (Oponent iterOponent: this.oponents){
			if (abs(-super.location.x+width/2-iterOponent.getLocation().x)<width/2+50){
				iterOponent.display();
			}
			if (DEBUG){
				noFill();
				if (abs(-super.location.x+width/2-iterOponent.getLocation().x)<width/2-50){
					stroke(0,255,0);
				} else {
					stroke(255,0,0);
				}
				rect(iterOponent.getLocation().x,iterOponent.getLocation().y,50,50);
			}
		}
		popMatrix();
	}

	@Override
	public void displayDebug(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		for (Oponent iterOponent: this.oponents){
			float distance=dist(iterOponent.getLocation().x,iterOponent.getLocation().y,
				    this.playerRef.getLocation().x,this.playerRef.getLocation().y);
			if (this.bulletsRef!=null && distance<200){
				stroke(255);
				line(this.playerRef.getLocation().x,this.playerRef.getLocation().y,
				     iterOponent.getLocation().x,iterOponent.getLocation().y);
			}
		}
		popMatrix();
	}

	private PVector getGroundAvoidanceForce(AutoAgent other){
		float groundY=this.groundRef.getGroundCoordinate(other.getLocation().x);
		if (groundY-other.getLocation().y<70){
			return other.getAvoidForce(new PVector(other.getLocation().x,groundY));
		}
		return new PVector(0,0);
	}
}

