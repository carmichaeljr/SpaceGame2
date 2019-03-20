private class OponentFlowField extends FlowField implements CollisionDetection,UpdateInterface {
	private float xOff;
	private float yOff;
	private float time;

	public OponentFlowField(float resolution){
		super(resolution);
		this.xOff=0;
		this.yOff=0;
		this.time=random(0,1000);
	}

	@Override
	public PVector generateFieldPVector(int x, int y){
		this.xOff=0.1*x;
		this.yOff=0.1*y;
		float theta=0;
		if (yOff<0.2){
			theta=HALF_PI;
		} else {
			theta=map(noise(this.xOff+this.time,this.yOff+this.time),0,1,0,TWO_PI);
		}
		return new PVector(super.resolution,theta);
	}

	@Override
	public void update(){
		this.time+=0.01;
		this.generateField();
		super.update();
		if (super.location.x>width/2){
			super.location.x=width/2;
			super.velocity.x=0;
		} else if (super.location.x+GAME_AREA.getSizeX()<width/2){
			super.location.x=(width/2)-GAME_AREA.getSizeX();
			super.velocity.x=0;
		}
	}

	@Override
	public boolean collided(Mover other){
		return false;
	}

	@Override
	public void performCollisionAction(String ... otherID){
		if (otherID[0].equalsIgnoreCase("player")){
			super.velocity.set(0,0);
		}
	}
}
