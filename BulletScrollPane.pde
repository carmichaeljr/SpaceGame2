private class Bullets extends ScrollerPane implements 
	UpdateInterface,DisplayInterface,KeyboardActionInterface,DebugDisplayInterface,CollisionDetection {
	private color _color;
	private ParticleSystem bullets;

	public Bullets(){
		this.bullets=new ParticleSystem();
		this._color=color(255,0,0);
	}

	public void setColor(color newC){
		this._color=newC;
	}

	public ArrayList<_Particle> getBullets(){
		return this.bullets.getParticles();
	}

	public void addBullet(PVector loc, float theta){
			Bullet bullet=new Bullet(loc);
			PVector temp=new PVector(sin(theta),cos(theta));
			temp.normalize();
			bullet.setVelocity(temp.mult(10));
			bullet.getAcceleration().mult(0);
			bullet.setColor(this._color);
			this.bullets.addParticleWithoutInit(bullet);
	}

	@Override
	public void update(){
		super.update();
		this.bullets.update();
	}

	@Override
	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		this.bullets.display();
		popMatrix();
	}

	@Override
	public void displayDebug(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		strokeWeight(5);
		stroke(0,100,255);
		noFill();
		rect(GAME_AREA.getSizeX()/2,GAME_AREA.getSizeY()/2,GAME_AREA.getSizeX()-10,GAME_AREA.getSizeY()-10);
		strokeWeight(1);
		popMatrix();
	}

	@Override
	public boolean collided(Mover other){
		boolean rv=false;
		ArrayList<_Particle> temp=this.bullets.getParticles();
		for (_Particle iterParticle: temp){
			Bullet iterBullet=(Bullet)iterParticle;
			if (iterBullet.collided(other)){
				iterBullet.setCollided(true);
				rv=true;
			}
		}
		return rv;
	}

	@Override
	public void performCollisionAction(String ... otherID){
		if (otherID[0].equalsIgnoreCase("oponent") || otherID[0].equalsIgnoreCase("player")){
			ArrayList<_Particle> temp=this.bullets.getParticles();
			for (_Particle iterParticle: temp){
				Bullet iterBullet=(Bullet)iterParticle;
				if (iterBullet.getCollided()){
					iterBullet.performCollisionAction("oponent");
				}
			}
		}
	}

	@Override
	public void performKeyboardAction(String ... args){
		if (args.length==3 && args[0].equalsIgnoreCase("add")){
			String[] arg1Parsed=args[1].split(",");
			PVector loc=new PVector(Float.parseFloat(arg1Parsed[0]),Float.parseFloat(arg1Parsed[1]));
			this.addBullet(loc,Float.parseFloat(args[2]));
		}
	}
}
