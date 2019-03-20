private class ParticleSystem {
	private ArrayList<_Particle> particles;
	private PVector location;
	private PVector initialVelocity;
	
	public ParticleSystem(){
		this.particles=new ArrayList<_Particle>();
		this.location=new PVector();
		this.initialVelocity=new PVector();
	}

	public ArrayList<_Particle> getParticles(){
		return this.particles;
	}
	
	public void setLocation(PVector location){
		this.location=location.get();
	}
	public PVector getLocation(){
		return this.location;
	}
	
	public void setInitialVelocity(PVector initialVelocity){
		this.initialVelocity=initialVelocity.get();
	}
	public PVector getInitialVelocity(){
		return this.initialVelocity;
	}
	
	public void addParticle(_Particle newParticle){
		newParticle.setLocation(this.location);
		newParticle.setVelocity(this.initialVelocity);
		newParticle.setMass(16);
		this.particles.add(newParticle);
	}

	public void addParticle(){
		_Particle temp=new _Particle();
		temp.setLocation(this.location);
		temp.setVelocity(this.initialVelocity);
		temp.setThetaVelocity(random(-0.03,0.03));
		temp.setMass(16);
		this.particles.add(temp);
	}

	public void addParticleWithoutInit(_Particle p){
		this.particles.add(p);
	}
	
	public void applyForce(PVector force){
		for (_Particle iterP: this.particles){
			iterP.applyForce(force);
		}
	}

	//public void applyRepeller(Repeller r){
	//	for (_Particle iterP: this.particles){
	//		PVector force=r.repel(iterP);
	//		iterP.applyForce(force);
	//	}
	//}

	public void update(){
		Iterator<_Particle> system=particles.iterator();
		while (system.hasNext()){
			_Particle p=system.next();
			p.update();
			if (p.isDead()){
				system.remove();
			}
		}
	}

	public void display(){
		Iterator<_Particle> system=particles.iterator();
		while (system.hasNext()){
			system.next().display();
		}
	}

	public boolean hasParticles(){
		if (this.particles.size()>0){
			return true;
		}
		return false;
	}
}
