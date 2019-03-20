private class Fire {
	private ArrayList<ParticleSystem> systems;
	private int lifespanDecrease;
	private int lifespan;

	public Fire(){
		super();
		this.systems=new ArrayList<ParticleSystem>();
		for (int i=0; i<3; i++){
			this.systems.add(new ParticleSystem());
		}
		this.lifespanDecrease=5;
		this.lifespan=1000;
	}

	public void setLifespan(int lifespan){
		this.lifespan=lifespan;
	}
	public int getLifespan(){
		return this.lifespan;
	}

	public void setLifespanDecrease(int lifespanDecrease){
		this.lifespanDecrease=lifespanDecrease;
	}
	public int getLifespanDecrease(){
		return this.lifespanDecrease;
	}

	public void setLocation(PVector location){
		for (ParticleSystem iterSys: this.systems){
			iterSys.setLocation(location);
		}
	}

	public void addParticle(){
		FireParticle temp=new FireParticle();
		float rand=random(0,9);
		int index=2;
		if (rand<3){
			index=0;
		} else if (rand<6){
			index=1;
		} 
		this.systems.get(index).addParticle(temp);
	}

	public void setInitialVelocity(PVector initVel){
		for (ParticleSystem iterSys: this.systems){
			iterSys.setInitialVelocity(initVel);
		}
	}

	public void update(){
		this.lifespan-=this.lifespanDecrease;
		if (this.lifespan>0){
			this.addParticle();
		} 
		for (ParticleSystem iterSys: this.systems){
			iterSys.update();
		}
	}

	public void display(){
		blendMode(ADD);
		for (ParticleSystem iterSys: this.systems){
			iterSys.display();
		}
		blendMode(BLEND);
	}

	public boolean isDead(){
		if (this.lifespan<0){
			return true;
		}
		return false;
	}
}

private class FireParticle extends _Particle {
	public FireParticle(){
		super();
	}

	@Override
	public void update(){
		super.applyForce(new PVector(random(-1,1),0));
		super.update();
	}

	@Override
	public void display(){
		noStroke();
		fill(255,50,50,super.lifespan);
		ellipse(super.location.x,super.location.y,10,10);
	}
}
