private class RoundComponentManager extends ComponentManager<RoundComponentContainer> {
	public RoundComponentManager(RoundComponentContainer componentContRef){
		super(componentContRef);
		super.componentContRef=componentContRef;
	}

	public void update(){
		super.update();
		ProgressBar progressBarRef=super.componentContRef.getProgressBar();
		Oponents oponentsRef=super.componentContRef.getOponents();
		Boss bossRef=super.componentContRef.getBoss();
		int totalEnemies=oponentsRef.getStartNumOponents();
		int numEnemiesKilled=oponentsRef.getDeathCount();
		if (bossRef.getActive()){
			totalEnemies+=bossRef.getStartNumOponents();
			numEnemiesKilled+=bossRef.getDeathCount();
		}
		progressBarRef.setPercentage((float)(totalEnemies-numEnemiesKilled)/(float)totalEnemies);
	}

	@Override
	public void display(){
		super.display();
		if (DEBUG){
			super.componentContRef.getOponentFlowField().display();
			super.componentContRef.getOponents().displayDebug();
			super.componentContRef.getGround().displayDebug();
			super.componentContRef.getDebugStats().display();
			super.componentContRef.getCas().displayDebug();
		}
		if (super.componentContRef.getDebugStats().getFrameRate()){
			super.componentContRef.getDebugStats().display();
		}
	}
}

private class RoundComponentKeyboardManager extends KeyboardManager<RoundComponentContainer> {
	public RoundComponentKeyboardManager(RoundComponentContainer componentContRef){
		super(componentContRef);
		this.componentContRef=componentContRef;
	}

	@Override
	protected void runSingleKeyReleaseActions(){
		super.runSingleKeyReleaseActions();
		KeyboardActionInterface playerRef=this.componentContRef.getPlayer();
		DebugStats debugRef=this.componentContRef.getDebugStats();
		playerRef.performKeyboardAction("thrusterOff");
		switch (key){
			case 'i': DEBUG=!DEBUG; break;
			case 'f': debugRef.setFrameRate(!debugRef.getFrameRate()); break;
			default: break;
		}
	}

	@Override
	protected void runRepeatedKeyPressActions(){
		KeyboardActionInterface playerRef=this.componentContRef.getPlayer();
		for (Character iterCharacter: this.keyBuffer){
			switch (iterCharacter){
				case 'a': playerRef.performKeyboardAction("leftThrusterOn"); break;
				case 'd': playerRef.performKeyboardAction("rightThrusterOn"); break;
				case 'w': playerRef.performKeyboardAction("bothThrusterOn"); break;
				case 's': playerRef.performKeyboardAction("downThruster"); break;
				case ' ': this.addBullet(); break;
				default: break;
			}
		}
	}

	private void addBullet(){
		Rocket playerRef=this.componentContRef.getPlayer();
		if (!playerRef.getCrashed() && playerRef.canShoot()){
			KeyboardActionInterface bulletsRef=this.componentContRef.getPlayerBullets();
			PVector loc=playerRef.getLocation();
			float theta=playerRef.getHeadTheta();
			bulletsRef.performKeyboardAction("add",
				String.format("%f,%f",loc.x,loc.y),
				String.format("%f",theta)
			);
			playerRef.resetShootTimer();
		}
	}
}

private class RoundComponentCollisionManager {
	private RoundComponentContainer componentContRef;

	public RoundComponentCollisionManager(RoundComponentContainer componentContRef){
		this.componentContRef=componentContRef;
	}

	public void update(){
		this.checkForPlayerGroundCollision();
		this.checkForOponentPlayerCollisions();
		this.checkForOponentGroundCollisions();
		this.checkForPlayerBulletOponentCollisions();
		this.checkForOponentBulletPlayerCollisions();
		if (this.componentContRef.getBoss().getActive()){
			this.checkForPlayerBulletBossCollisions();
			this.checkForBossGroundCollision();
		}
	}

	public void checkForPlayerGroundCollision(){
		CollisionDetection playerRef=this.componentContRef.getPlayer();
		CollisionDetection groundRef=this.componentContRef.getGround();
		CollisionDetection flowFieldRef=this.componentContRef.getOponentFlowField();
		if (groundRef.collided(this.componentContRef.getPlayer())){
			playerRef.performCollisionAction("ground");
			groundRef.performCollisionAction("player");
			flowFieldRef.performCollisionAction("player");
		}
	}

	private void checkForBossGroundCollision(){
		ArrayList<Oponent> oponentsRef=this.componentContRef.getBoss().getOponents();
		CollisionDetection ground=this.componentContRef.getGround();
		for (Oponent iterOponent: oponentsRef){
			if (ground.collided(iterOponent)){
				iterOponent.setCollided(true);
				iterOponent.performCollisionAction("ground");
			}
		}
	}

	public void checkForOponentPlayerCollisions(){
		CollisionDetection playerRef=this.componentContRef.getPlayer();
		ArrayList<Oponent> oponentRef=this.componentContRef.getOponents().getOponents();
		CAScrollPane casRef=this.componentContRef.getCas();
		for (Oponent iterOponent: oponentRef){
			if (!iterOponent.getCrashed() &&
			    iterOponent.collided(this.componentContRef.getPlayer())){
				playerRef.performCollisionAction("oponent");
				iterOponent.performCollisionAction("player");
				casRef.addCA(iterOponent.getLocation());
			}
		}
	}

	public void checkForOponentGroundCollisions(){
		CollisionDetection groundRef=this.componentContRef.getGround();
		ArrayList<Oponent> oponentRef=this.componentContRef.getOponents().getOponents();
		for (Oponent iterOponent: oponentRef){
			if (groundRef.collided(iterOponent)){
				iterOponent.performCollisionAction("ground");
			}
		}
	}

	public void checkForPlayerBulletOponentCollisions(){
		Oponents oponentsRef=this.componentContRef.getOponents();
		ArrayList<Oponent> oponentRef=this.componentContRef.getOponents().getOponents();
		Bullets bulletsRef=this.componentContRef.getPlayerBullets();
		CAScrollPane casRef=this.componentContRef.getCas();
		for (Oponent iterOponent: oponentRef){
			if (bulletsRef.collided(iterOponent) && !iterOponent.getCrashed()){
				casRef.addCA(iterOponent.getLocation());
				bulletsRef.performCollisionAction("oponent");
				iterOponent.performCollisionAction("bullet");
			}
		}
	}

	public void checkForOponentBulletPlayerCollisions(){
		Rocket playerRef=this.componentContRef.getPlayer();
		Bullets oponentBullets=this.componentContRef.getOponentBullets();
		CAScrollPane casRef=this.componentContRef.getCas();
		if (oponentBullets.collided(playerRef)){
			casRef.addCA(playerRef.getLocation());
			oponentBullets.performCollisionAction("player");
			playerRef.performCollisionAction("bullet");
		}
	}

	public void checkForPlayerBulletBossCollisions(){
		Boss bossRef=this.componentContRef.getBoss();
		CAScrollPane casRef=this.componentContRef.getCas();
		ArrayList<_Particle> bulletsRef=this.componentContRef.getPlayerBullets().getBullets();
		for (_Particle iterParticle: bulletsRef){
			Bullet iterBullet=(Bullet)iterParticle;
			if (bossRef.collided(iterBullet)){
				bossRef.performCollisionAction("bullet");
				iterBullet.performCollisionAction("oponent");
				casRef.addCA(iterBullet.getLocation());
			}
		}
	}

}
