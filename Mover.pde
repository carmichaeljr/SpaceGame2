private abstract class Mover {
	protected final PVector GRAVITY=new PVector(0,0.1);
	protected PVector location;
	protected PVector velocity;
	protected PVector acceleration;
	protected float thetaAcceleration;
	protected float thetaVelocity;
	protected float theta;
	protected float mass;
	
	public Mover(){
		this.acceleration=new PVector();
		this.velocity=new PVector();
		this.location=new PVector();
		this.thetaAcceleration=0;
		this.thetaVelocity=0;
		this.theta=0;
		this.mass=1;
	}
	
	public void setAcceleration(PVector acceleration){
		this.acceleration=acceleration.get();
	}
	public PVector getAcceleration(){
		return this.acceleration;
	}
	public void setVelocity(PVector velocity){
		this.velocity=velocity.get();
	}
	public PVector getVelocity(){
		return this.velocity;
	}
	public void setLocation(PVector location){
		this.location=location.get();
	}
	public PVector getLocation(){
		return this.location;
	}
	
	public void setThetaAcceleration(float thetaAcceleration){
		this.thetaAcceleration=thetaAcceleration;
	}
	public float getThetaAcceleration(){
		return this.thetaAcceleration;
	}
	public void setThetaVelocity(float thetaVelocity){
		this.thetaVelocity=thetaVelocity;
	}
	public float getThetaVelocity(){
		return this.thetaVelocity;
	}
	public void setTheta(float theta){
		this.theta=theta;
		if (this.theta>TWO_PI){
			this.theta-=TWO_PI;
		} else if (this.theta<-TWO_PI){
			this.theta+=TWO_PI;
		}
	}
	public float getTheta(){
		return this.theta;
	}
	
	public void setMass(float mass){
		this.mass=mass;
	}
	public float getMass(){
		return this.mass;
	}

	public void applyForce(PVector force){
		//Newtons second law: F=M*A -> A=F/M
		PVector newForce=PVector.div(force,this.mass);
		this.acceleration.add(newForce);
	}
	
	public void applyRotationalForce(float force){
		this.thetaAcceleration+=(force/this.mass);
	}
	
	public void update(){
		this.velocity.add(this.acceleration);
		this.location.add(this.velocity);
		this.thetaVelocity+=this.thetaAcceleration;
		this.theta+=this.thetaVelocity;
		this.acceleration.mult(0);
		this.thetaAcceleration=0;
	}
	
	public abstract void display();
}
