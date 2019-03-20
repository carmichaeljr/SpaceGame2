private class RoundComponentContainer extends ComponentContainer {
	private PauseButton pauseButton;
	private Boss boss;
	private Trees trees;
	private Rocket player;
	private Ground ground;
	private CAScrollPane cas;
	private Oponents oponents;
	private TickerFont timerFont;
	private DebugStats debugStats;
	private Bullets playerBullets;
	private Bullets oponentBullets;
	private ProgressBar progressBar;
	private OponentFlowField oponentFlowField;

	public RoundComponentContainer(){
		super();
		this.setupPauseButton();
		this.setupTimerFont();
		this.setupResetComponents();
		this.setupInteractiveComponents();
		this.initilize();
	}

	public void initilize(){
		this.setupProgressBar();
		this.setupCas();
		this.setupGround();
		this.setupTrees();
		this.setupOponentFlowField();
		this.setupPlayer();
		this.setupPlayerBullets();
		this.setupOponentBullets();
		this.setupOponents();
		this.setupBoss();
		this.setupPlayerAttachments();
		this.setupDebugStats();
		this.setupUpdateComponents();
		this.setupDisplayComponents();
	}

	private void setupProgressBar(){
		this.progressBar=new ProgressBar();
		this.progressBar.setLocation(new PVector(width/2,height-10));
		this.progressBar.setSize(width,20);
		this.progressBar.setDescription("Enemies Alive");
		this.progressBar.setColor(color(100,0,0));
		this.progressBar.setBackgroundColor(color(0));
		this.progressBar.setTextColor(color(255));
	}

	private void setupCas(){
		this.cas=new CAScrollPane();
	}

	private void setupGround(){
		this.ground=new Ground();
		this.ground.setMass(10);  //Has to be same as rocket for scroll effect
		this.ground.setLocation(new PVector(0,height*0.8));
		this.ground.setNumGroundWaves(4);
		this.ground.setGroundGranularity(5);
		for (int i=0; i<5; i++){
			this.ground.appendWave(random(height/20,height/15),random(0.003,0.01));
		}
	}

	private void setupTrees(){
		this.trees=new Trees();
		this.trees.setGroundRef(this.ground);
		this.trees.populateTrees();
	}

	private void setupOponentFlowField(){
		this.oponentFlowField=new OponentFlowField(20);
		this.oponentFlowField.setMass(10);  //has to be same as rocket for scroll effect
	}

	private void setupPlayer(){
		this.player=new Rocket();
		this.player.setMass(10);
		this.player.setLocation(new PVector(width/2,height/2));
		this.player.setForceFieldColor(color(56,211,255));
	}
	private void setupPlayerAttachments(){
		this.player.addAttachment(this.ground);
		this.player.addAttachment(this.oponentFlowField);
		this.player.addAttachment(this.oponents);
		this.player.addAttachment(this.playerBullets);
		this.player.addAttachment(this.oponentBullets);
		this.player.addAttachment(this.cas);
		this.player.addAttachment(this.trees);
		this.player.addAttachment(this.boss);
	}

	private void setupPlayerBullets(){
		this.playerBullets=new Bullets();
	}

	private void setupOponentBullets(){
		this.oponentBullets=new Bullets();
		this.oponentBullets.setColor(color(50,255,0));
	}

	private void setupOponents(){
		this.oponents=new Oponents(20);
		this.oponents.setPlayerRef(this.player);
		this.oponents.setFlowFieldRef(this.oponentFlowField);
		this.oponents.setGroundRef(this.ground);
		this.oponents.setBulletsRef(this.oponentBullets);
	}

	private void setupBoss(){
		this.boss=new Boss();
		this.boss.setMass(10);
		this.boss.setFlowFieldRef(this.oponentFlowField);
		this.boss.setGroundRef(this.ground);
		this.boss.setPlayerRef(this.player);
		this.boss.setBulletsRef(this.oponentBullets);
		this.boss.setLength(20);
	}

	private void setupPauseButton(){
		this.pauseButton=new PauseButton();
		this.pauseButton.setSize(40,40);
		this.pauseButton.setLocation(new PVector(width-30,30));
		this.pauseButton.setMainColor(color(58,58,58));
		this.pauseButton.setHoverColor(color(145,145,145));
		this.pauseButton.setContentColor(color(186,186,186));
		this.pauseButton.setKeyReleasedTrigger('p');
	}

	private void setupTimerFont(){
		this.timerFont=new TickerFont(40);
		this.timerFont.setLocation(new PVector(width-100,40));
		this.timerFont.setColor(color(255));
		this.timerFont.setBackgroundColor(color(0));
		this.timerFont.setDisplayText(0);
	}

	private void setupDebugStats(){
		this.debugStats=new DebugStats();
	}

	private void setupUpdateComponents(){
		super.getUpdateComponents().clear();
		super.addUpdateComponent(this.cas);
		super.addUpdateComponent(this.ground);
		super.addUpdateComponent(this.trees);
		super.addUpdateComponent(this.oponentFlowField);
		super.addUpdateComponent(this.player);
		super.addUpdateComponent(this.playerBullets);
		super.addUpdateComponent(this.oponentBullets);
		super.addUpdateComponent(this.oponents);
		super.addUpdateComponent(this.boss);
		super.addUpdateComponent(this.timerFont);
	}
	private void setupDisplayComponents(){
		super.getDisplayComponents().clear();
		super.addDisplayComponent(this.timerFont);
		super.addDisplayComponent(this.ground);
		super.addDisplayComponent(this.trees);
		super.addDisplayComponent(this.cas);
		super.addDisplayComponent(this.player);
		super.addDisplayComponent(this.oponents);
		super.addDisplayComponent(this.boss);
		super.addDisplayComponent(this.playerBullets);
		super.addDisplayComponent(this.oponentBullets);
		super.addDisplayComponent(this.progressBar);
		super.addDisplayComponent(this.pauseButton);
	}

	private void setupResetComponents(){
		super.addResetComponent(this.pauseButton);
	}

	private void setupInteractiveComponents(){
		super.addInteractiveComponent(this.pauseButton);
	}

	public Rocket getPlayer(){
		return this.player;
	}
	public Ground getGround(){
		return this.ground;
	}
	public Trees getTrees(){
		return this.trees;
	}
	public OponentFlowField getOponentFlowField(){
		return this.oponentFlowField;
	}
	public Oponents getOponents(){
		return this.oponents;
	}
	public DebugStats getDebugStats(){
		return this.debugStats;
	}
	public Bullets getPlayerBullets(){
		return this.playerBullets;
	}
	public Bullets getOponentBullets(){
		return this.oponentBullets;
	}
	public CAScrollPane getCas(){
		return this.cas;
	}
	public PauseButton getPauseButton(){
		return this.pauseButton;
	}
	public TickerFont getTimerFont(){
		return this.timerFont;
	}
	public ProgressBar getProgressBar(){
		return this.progressBar;
	}
	public Boss getBoss(){
		return this.boss;
	}
}
