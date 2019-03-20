private class Rocket extends Scroller implements 
	CollisionDetection,KeyboardActionInterface,UpdateInterface,DisplayInterface {
	private HashMap<String, PVector> presetForces;
	private PVector rightAcceleration;
	private PVector leftAcceleration; 
	private PVector upAcceleration;
	private PVector downAcceleration;
	private ParticleSystem[] exhaust;
	private ForceField forceField;
	private Timer shotTimer;
	private boolean thrusterOn;
	private boolean crashed;
	private Fire crashFire;

	public Rocket(){
		super();
		this.rightAcceleration=new PVector();
		this.leftAcceleration=new PVector();
		this.upAcceleration=new PVector();
		this.downAcceleration=new PVector();
		this.presetForces=new HashMap<String, PVector>();
		this.forceField=new ForceField();
		this.exhaust=new ParticleSystem[2];
		for (int i=0; i<this.exhaust.length; i++){
			this.exhaust[i]=new ParticleSystem();
		}
		this.thrusterOn=false;
		this.crashed=false;
		this.crashFire=new Fire();
		this.crashFire.setInitialVelocity(new PVector(0,-1));
		this.crashFire.setLifespanDecrease(5);
		this.crashFire.setLifespan(10000);
		this.forceField.setRadius(super.mass*2);
		this.forceField.setDincrement(5);
		this.shotTimer=new Timer(0.1);
		this.shotTimer.start();
		this.initPresetForces();
	}

	private void initPresetForces(){
		this.rightAcceleration.set(1,-0.05);
		this.leftAcceleration.set(-1,-0.05);
		this.upAcceleration.set(0,-0.5);
		this.downAcceleration.set(0,0.5);
		this.presetForces.put("rightThruster",this.rightAcceleration);
		this.presetForces.put("leftThruster",this.leftAcceleration);
		this.presetForces.put("upThruster",this.upAcceleration);
		this.presetForces.put("downThruster",this.downAcceleration);
	}

	@Override
	public PVector getLocation(){
		return super.locationWithoutScroll;
	}
	@Override
	public void setLocation(PVector loc){
		super.setLocation(loc);
		super.locationWithoutScroll.set(loc);
	}

	@Override
	public void setMass(float mass){
		super.setMass(mass);
		this.forceField.setRadius(super.mass*4);
	}

	public void setThrusterOn(boolean thrusterOn){
		this.thrusterOn=thrusterOn;
	}
	public boolean getThrusterOn(){
		return this.thrusterOn;
	}

	public void setCrashed(boolean crashed){
		this.crashed=crashed;
	}
	public boolean getCrashed(){
		return this.crashed;
	}

	public float getHeadTheta(){
		return -this.theta;
	}

	public boolean canShoot(){
		return this.shotTimer.checkTimer();
	}
	public void resetShootTimer(){
		this.shotTimer.reset();
		this.shotTimer.start();
	}

	public void setForceFieldColor(color c){
		this.forceField.setColor(c);
	}

	public void applyPresetForce(String forceID){
		if (this.presetForces.containsKey(forceID)){
			super.applyForce(this.presetForces.get(forceID));
		}	
	}
	
	public void checkEdges(){
		if (super.locationWithoutScroll.x>GAME_AREA.getSizeX()){
			super.locationWithoutScroll.x=GAME_AREA.getSizeX();
			super.velocity.x=0;
			super.acceleration.x=0;
		} else if (super.locationWithoutScroll.x<0){
			super.locationWithoutScroll.x=0;
			super.velocity.x=0;
			super.acceleration.x=0;
		}
		if (super.location.y>height){
			super.location.y=height;
			super.velocity.y=0;
			super.acceleration.y=0;
		} else if (super.location.y<0){
			super.location.y=0;
			super.velocity.y=0;
			super.acceleration.y=0;
		}
	}
	
	@Override
	public void update(){
		super.applyForce(super.GRAVITY);
		super.update();
		super.theta=-atan2(super.velocity.x,super.velocity.y);
		if (!this.crashed){
			super.getVelocity().mult(0.99);
			this.forceField.setLocation(super.location.get());
			this.updateExhaust();
			this.checkEdges();
		} else {
			this.crashFire.setLocation(new PVector(super.location.x,super.location.y));
			this.crashFire.update();
		}
	}

	private void updateExhaust(){
		PVector polarCoordinates1=new PVector(super.theta+PI+atan(10/7),sqrt((10*10)+(7*7)));
		PVector polarCoordinates2=new PVector(super.theta-atan(10/7),sqrt((10*10)+(7*7)));
		float x1=polarCoordinates1.y*cos(polarCoordinates1.x);	
		float y1=polarCoordinates1.y*sin(polarCoordinates1.x);
		float x2=polarCoordinates2.y*cos(polarCoordinates2.x);
		float y2=polarCoordinates2.y*sin(polarCoordinates2.x);
		this.exhaust[0].setLocation(new PVector(super.location.x+x1,super.location.y+y1));
		this.exhaust[1].setLocation(new PVector(super.location.x+x2,super.location.y+y2));
		PVector newInitVelocity=super.velocity.get();
		newInitVelocity.normalize();
		newInitVelocity.mult(-map(super.velocity.mag(),0,50,0,5));
		newInitVelocity.y+=random(-0.1,0.1);
		this.exhaust[0].setInitialVelocity(newInitVelocity);
		this.exhaust[1].setInitialVelocity(newInitVelocity);
		if (this.thrusterOn){
			this.exhaust[0].addParticle();
			this.exhaust[1].addParticle();
		}
		for (int i=0; i<this.exhaust.length; i++){
			this.exhaust[i].update();
		}
	}

	@Override
	public void display(){
		this.displayRocket();
		if (this.crashed){
			this.crashFire.display();
		} else {
			this.forceField.display();
			this.displayExhaust();
		}
	}

	private void displayRocket(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		rotate(super.getTheta()+HALF_PI);
		fill(175);
		noStroke();
		rect(-super.mass/2,-super.mass/2-2,super.mass,super.mass/2-1);
		rect(-super.mass/2,super.mass/2+2,super.mass,super.mass/2-1);
		stroke(100);
		fill(200);
		quad(0,0,-super.mass,super.mass*2,super.mass*2,0,-super.mass,-super.mass*2);
		popMatrix();
	}

	private void displayExhaust(){
		for (int i=0; i<this.exhaust.length; i++){
			this.exhaust[i].display();
		}
	}

	@Override
	public void performKeyboardAction(String ... args){
		if (!this.crashed){
			if (args[0].equalsIgnoreCase("rightThrusterOn")){
				this.applyPresetForce("rightThruster");
				this.thrusterOn=true;
			} else if (args[0].equalsIgnoreCase("leftThrusterOn")){
				this.applyPresetForce("leftThruster");
				this.thrusterOn=true;
			} else if (args[0].equalsIgnoreCase("bothThrusterOn")){
				this.applyPresetForce("upThruster");
				this.thrusterOn=true;
			} else if  (args[0].equalsIgnoreCase("downThruster")){
				this.applyPresetForce("downThruster");
				this.thrusterOn=true;
			} else if (args[0].equalsIgnoreCase("thrusterOff")){
				this.thrusterOn=false;
			}
		}
	}

	@Override
	public boolean collided(Mover other){
		return false;
	}

	@Override
	public void performCollisionAction(String ... otherID){
		if (otherID[0].equalsIgnoreCase("ground")){
			super.velocity.set(0,0);
			super.acceleration.set(0,0);
			this.crashed=true;
		} else if (otherID[0].equalsIgnoreCase("oponent")){
			for (int i=0; i<3; i++){
				this.forceField.dincrementEffectivness();
			}
			this.applyForceFieldChanges();
		} else if (otherID[0].equalsIgnoreCase("bullet")){
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
}
