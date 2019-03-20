private class Bullet extends _Particle implements CollisionDetection {
	private boolean collided;
	private color _color;

	public Bullet(PVector loc){
		super();
		super.location=loc.get();
		this.collided=false;
		this._color=color(255,255,255);
	}

	public void setColor(color newC){
		this._color=newC;
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
		if (this.collided==true){
			super.lifespan=0;
		}
		this.collided=false;
	}

	@Override
	public void display(){
		float radius=map(super.lifespan,0,255,0,10);
		fill(this._color);
		//stroke(255,0,0,255-super.lifespan);
		ellipse(super.location.x,super.location.y,radius,radius);
	}

	@Override
	public boolean collided(Mover other){
		float dist=dist(super.location.x,super.location.y,
				other.getLocation().x,other.getLocation().y);
		if (dist<this.mass/2+other.getMass()/2){
			return true;
		}
		return false;
	}

	@Override
	public void performCollisionAction(String ... otherID){
		if (otherID[0].equalsIgnoreCase("oponent")){
			super.lifespan=0;
		}
	}
}
