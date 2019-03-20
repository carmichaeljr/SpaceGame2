public class _Particle extends Mover {
	protected float lifespan;
	
	public _Particle(){
		super();
		this.lifespan=255;
	}

	public void setLifespan(float lifespan){
		this.lifespan=lifespan;
	}
	public float getLifespan(){
		return this.lifespan;
	}
	
	@Override
	public void update(){
		super.update();
		this.lifespan-=5;
	}
	
	@Override
	public void display(){
		noStroke();
		fill(this.lifespan);
		ellipse(super.location.x,super.location.y,5,5);
	}

	public boolean isDead(){
		if (this.lifespan<=0){
			return true;
		}
		return false;
	}
}
