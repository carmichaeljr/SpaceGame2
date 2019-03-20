private class Boss extends ScrollerPane implements UpdateInterface,DisplayInterface,CollisionDetection {
	private ArrayList<ArrayList<BossOponent>> oponents;
	private ArrayList<BossOponent> shotOponents;
	private FlowField flowFieldRef;
	private Bullets bulletsRef;
	private Ground groundRef;
	private Mover playerRef;
	private int deathCount;
	private int length;
	private boolean active;

	private class BossOponent extends Oponent {
		public BossOponent(){
			super();
		}

		@Override
		public void display(){
			if (!super.crashed){
				pushMatrix();
				super.forceField.display();
				translate(super.location.x,super.location.y);
				rotate(super.theta);
				this.displayShip();
				popMatrix();
			} else {
				super.crashFire.display();
			}
		}

		@Override
		protected void displayShip(){
			fill(255,200,200);
			noStroke();
			ellipse(0,super.mass/4,super.mass/2,super.mass/3);
			ellipse(0,0,super.mass,super.mass/2);
			fill(0);
			ellipse(-super.mass/4,0,super.mass/5,super.mass/5);
			ellipse(0,0,super.mass/5,super.mass/5);
			ellipse(super.mass/4,0,super.mass/5,super.mass/5);
		}
	}
	
	public Boss(){
		this.oponents=new ArrayList<ArrayList<BossOponent>>();
		this.oponents.add(new ArrayList<BossOponent>());
		this.shotOponents=new ArrayList<BossOponent>();
		this.flowFieldRef=null;
		this.bulletsRef=null;
		this.playerRef=null;
		this.deathCount=0;
		this.length=0;
		this.active=false;
	}

	public void setActive(boolean active){
		this.active=active;
	}
	public boolean getActive(){
		return this.active;
	}

	public int getStartNumOponents(){
		return this.length;
	}

	public int getNumOponents(){
		return this.length-this.deathCount;
	}

	public int getDeathCount(){
		return this.deathCount;
	}

	public void setFlowFieldRef(FlowField flowField){
		this.flowFieldRef=flowField;
	}
	public void setGroundRef(Ground groundRef){
		this.groundRef=groundRef;
	}

	public void setBulletsRef(Bullets bullets){
		this.bulletsRef=bullets;
	}
	public Bullets getBulletsRef(){
		return this.bulletsRef;
	}

	public Mover getPlayerRef(){
		return this.playerRef;
	}
	public void setPlayerRef(Mover playerRef){
		this.playerRef=playerRef;
	}

	public void setBurstTime(float timeInSec){
		for (ArrayList<BossOponent> iterList: this.oponents){
			for (BossOponent iterOponent: iterList){
				iterOponent.setShotInterval(timeInSec);
			}
		}
	}

	public void setLength(int length){
		this.length=length;
		ArrayList<BossOponent> temp=this.oponents.get(0);
		if (temp.size()<length){
			int diff=length-temp.size();
			for (int i=0; i<diff; i++){
				this.addOponent(this.oponents.get(0));
			}
		} else if (temp.size()>length){
			for (int i=temp.size()-1; i>=length; i++){
				temp.remove(i);
			}
		}
	}

	public ArrayList<Oponent> getOponents(){
		ArrayList<Oponent> rv=new ArrayList<Oponent>();
		for (ArrayList<BossOponent> iterList: this.oponents){
			rv.addAll(iterList);
		}
		rv.addAll(this.shotOponents);
		return rv;
	}

	private void addOponent(ArrayList<BossOponent> list){
		BossOponent temp=new BossOponent();
		temp.setMass(40);
		PVector previous=null;
		if (list.size()>0){
			previous=list.get(list.size()-1).getLocation();
		} else {
			previous=new PVector(random(width,GAME_AREA.getSizeX()),random(0,GAME_AREA.getSizeY()/2));
		}
		previous.x+=temp.mass;
		temp.setLocation(previous);
		temp.getForceField().setColor(color(148,255,0));
		temp.getForceField().setDincrement(255/2);
		list.add(temp);
	}

	public void setForceFieldLevel(int level){
		for (ArrayList<BossOponent> iterList: this.oponents){
			for (Oponent iterOponent: iterList){
				iterOponent.getForceField().setEffectiveness((level+1)*255/MAX_LEVEL);
			}
		}
	}

	public void update(){
		super.update();
		this.updateListHeads();
		this.updateListTails();
		this.updateAllOponents();
		this.checkForSplitOffs();
		this.removeShotOponents();
		this.removeEmptySnakes();
	}

	private void updateListHeads(){
		for (ArrayList<BossOponent> iterList: this.oponents){
			PVector flowFieldForce=iterList.get(0).getFollowForce(this.flowFieldRef);
			PVector gaf=this.getGroundAvoidanceForce(iterList.get(0));
			iterList.get(0).applyForce(flowFieldForce);
			iterList.get(0).applyForce(gaf.mult(5));
		}
	}

	private void updateListTails(){
		for (ArrayList<BossOponent> iterList: this.oponents){
			for (int i=iterList.size()-2; i>=0; i--){
				PVector start=iterList.get(i+1).getLocation().get();
				PVector _end=iterList.get(i).getLocation().get();
				float dist=dist(start.x,start.y,_end.x,_end.y);
				PVector translation=PVector.sub(_end,start);
				if (dist>=GAME_AREA.getSizeX()-width){
					_end.x-=GAME_AREA.getSizeX();
				} 
				translation=PVector.sub(_end,start);
				translation.mult(0.1);
				iterList.get(i+1).getLocation().add(translation);
			}
		}
	}

	private void updateAllOponents(){
		for (ArrayList<BossOponent> iterList: this.oponents){
			for (BossOponent iterOponent: iterList){
				this.checkForBossShot(iterOponent);
				iterOponent.update();
			}
		}
		for (BossOponent iterOponent: this.shotOponents){
			iterOponent.applyForce(new PVector(0,2));
			iterOponent.update();
		}
	}

	private void checkForBossShot(BossOponent oponent){
		float distance=dist(oponent.getLocation().x,oponent.getLocation().y,
				    this.playerRef.getLocation().x,this.playerRef.getLocation().y);
		if (!oponent.getCrashed() && oponent.canShoot() && distance<300 && this.bulletsRef!=null){
			float theta=atan2(this.playerRef.getLocation().y-oponent.getLocation().y,
					  this.playerRef.getLocation().x-oponent.getLocation().x);
			this.bulletsRef.addBullet(oponent.getLocation(),-theta+HALF_PI);//+random(-PI/10,PI/10));
			oponent.resetShootTimer();
		}
	}

	private void checkForSplitOffs(){
		int startSize=this.oponents.size();
		for (int k=startSize-1; k>=0; k--){
			ArrayList<BossOponent> iterList=this.oponents.get(k);
			int splitEnd=iterList.size();
			for (int i=iterList.size()-1; i>=0; i--){
				if (iterList.get(i).getCrashed()){
					this.createNewSnake(iterList,i+1,splitEnd);
					splitEnd=i;
				}
			}
		}
	}

	private void createNewSnake(ArrayList<BossOponent> list, int startIndex, int endIndex){
		if (endIndex-startIndex>1){
			ArrayList<BossOponent> newSnake=new ArrayList<BossOponent>();
			for (int j=startIndex; j<endIndex; j++){
				newSnake.add(list.get(j));
			}
			list.subList(startIndex,endIndex).clear();
			this.oponents.add(newSnake);
		}
	}

	private void removeShotOponents(){
		for (ArrayList<BossOponent> iterList: this.oponents){
			for (int i=iterList.size()-1; i>=0; i--){
				if (iterList.get(i).getCrashed()){
					this.shotOponents.add(iterList.get(i));
					iterList.remove(i);
					deathCount++;
				}
			}
		}
	}

	private void removeEmptySnakes(){
		for (int i=this.oponents.size()-1; i>=0; i--){
			if (this.oponents.get(i).size()==0){
				this.oponents.remove(i);
			}
		}
	}

	private PVector getGroundAvoidanceForce(AutoAgent other){
		float groundY=this.groundRef.getGroundCoordinate(other.getLocation().x);
		if (groundY-other.getLocation().y<70){
			return other.getAvoidForce(new PVector(other.getLocation().x,groundY));
		}
		return new PVector(0,0);
	}

	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		for (ArrayList<BossOponent> iterList: this.oponents){
			this.displaySnake(iterList);
		}
		this.displaySnake(this.shotOponents);
		popMatrix();
	}

	private void displaySnake(ArrayList<BossOponent> list){
		for (BossOponent iterOponent: list){
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
	}

	@Override
	public boolean collided(Mover other){
		boolean rv=false;
		for (ArrayList<BossOponent> iterList: this.oponents){
			for (BossOponent iterOponent: iterList){
				if (iterOponent.collided(other)){
					iterOponent.setCollided(true);
					rv=true;
				}
			}
		}
		return rv;
	}

	@Override
	public void performCollisionAction(String ... otherID){
		if (otherID.length>0){
			for (ArrayList<BossOponent> iterList: this.oponents){
				for (BossOponent iterOponent: iterList){
					if (iterOponent.getCollided()){
						iterOponent.performCollisionAction(otherID[0]);
					}
				}
			}
		}
	}
}
