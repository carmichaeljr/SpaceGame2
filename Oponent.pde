private class Oponent extends AutoAgent implements CollisionDetection {
	protected Timer shotTimer;
	protected Fire crashFire;
	protected ForceField forceField;
	protected boolean crashed;
	protected boolean collided;

	public Oponent(){
		super();
		this.shotTimer=new Timer();
		this.shotTimer.start();
		this.forceField=new ForceField();
		this.forceField.setRadius(super.mass/2);
		this.crashFire=new Fire();
		this.crashFire.setInitialVelocity(new PVector(0,-0.75));
		this.crashFire.setLifespanDecrease(5);
		this.crashFire.setLifespan(1000);
		this.collided=false;
		this.crashed=false;
	}

	@Override
	public void setMass(float mass){
		super.setMass(mass);
		this.forceField.setRadius(super.mass/2);
	}

	@Override
	public void setLocation(PVector loc){
		super.setLocation(loc);
		this.forceField.setLocation(loc);
	}

	public ForceField getForceField(){
		return this.forceField;
	}

	public void setShotInterval(float timeInSec){
		this.shotTimer.setTime(timeInSec);
	}
	public boolean canShoot(){
		return this.shotTimer.checkTimer();
	}
	public void resetShootTimer(){
		this.shotTimer.reset();
		this.shotTimer.start();
	}

	public boolean getCrashed(){
		return this.crashed;
	}
	public void setCrashed(boolean crashed){
		this.crashed=crashed;
	}

	public boolean getCollided(){
		return this.collided;
	}
	public void setCollided(boolean collided){
		this.collided=collided;
	}

	@Override
	public void update(){
		super.update();
		if (!this.crashed){
			this.checkEdges();
			this.forceField.setLocation(super.location.get());
			super.theta=atan2(super.velocity.y,super.velocity.x);
		} else {
			this.crashFire.setLocation(new PVector(super.location.x,super.location.y));
			this.crashFire.update();
		}
	}

	public void checkEdges(){
		if (super.location.x<0){
			super.location.set(new PVector(GAME_AREA.getSizeX(),super.location.y));
		} else if (super.location.x>GAME_AREA.getSizeX()){
			super.location.set(new PVector(0,super.location.y));
		}
		if (super.location.y<0){
			super.location.set(new PVector(super.location.x,0));
		} else if (super.location.y>GAME_AREA.getSizeY()){
			super.location.set(new PVector(super.location.x,GAME_AREA.getSizeY()));
		}
	}

	@Override
	public void display(){
		if (!this.crashed){
			this.forceField.display();
			pushMatrix();
			translate(super.location.x,super.location.y);
			rotate(super.theta);
			this.displayShip();
			popMatrix();
		} else {
			this.crashFire.display();
		}
	}

	protected void displayShip(){
		fill(255);
		noStroke();
		ellipse(0,super.mass/4,super.mass/2,super.mass/3);
		ellipse(0,0,super.mass,super.mass/2);
		fill(0);
		ellipse(-super.mass/4,0,super.mass/5,super.mass/5);
		ellipse(0,0,super.mass/5,super.mass/5);
		ellipse(super.mass/4,0,super.mass/5,super.mass/5);
	}

	@Override
	public boolean collided(Mover other){
		float distance=dist(super.location.x,super.location.y,other.getLocation().x,other.getLocation().y);
		if (distance<super.mass/3+other.getMass()){
			return true;
		}
		return false;
	}

	@Override
	public void performCollisionAction(String ... otherID){
		if (otherID[0].equalsIgnoreCase("ground")){
			this.crashed=true;
			super.velocity.set(0,0);
			super.acceleration.set(0,0);
		} else if (otherID[0].equalsIgnoreCase("player") && !this.crashed){
			this.crashed=true;
			this.acceleration.set(0,0);
		} else if (otherID[0].equalsIgnoreCase("bullet") && !this.crashed){
			this.applyForceFieldChanges();
		}
	}

	private void applyForceFieldChanges(){
		this.forceField.dincrementEffectivness();
		if (this.forceField.getEffectiveness()<=0){
			super.acceleration.set(0,0);
			this.crashed=true;
		}
	}

	public boolean isDead(){
		if (this.crashed && this.crashFire.isDead()){
			return true;
		}
		return false;
	}
}

