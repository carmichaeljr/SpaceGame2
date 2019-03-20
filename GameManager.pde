private class GameManager extends FrameManager<GameCrossFrameData> {
	private MainMenuManager menuManager;
	private RoundManager roundManager;
	private PauseMenuManager pauseMenuManager;
	private HelpMenuManager helpMenuManager;
	private ResetMenuManager resetMenuManager;

	public GameManager(){
		super("data/settings.txt");
	}

	@Override
	public void setupCrossFrameData(){
		super.crossFrameData=new GameCrossFrameData(super.settingsManager);
	}

	@Override
	protected void populateManagersList(){
		this.roundManager=new RoundManager(super.crossFrameData);
		this.menuManager=new MainMenuManager(super.crossFrameData);
		this.pauseMenuManager=new PauseMenuManager(super.crossFrameData);
		this.helpMenuManager=new HelpMenuManager(super.crossFrameData);
		this.resetMenuManager=new ResetMenuManager(super.crossFrameData);
		super.managers.add(this.roundManager);
		super.managers.add(this.menuManager);
		super.managers.add(this.pauseMenuManager);
		super.managers.add(this.helpMenuManager);
		super.managers.add(this.resetMenuManager);
	}

	@Override
	public void exit(){
		super.exit();
		BACKGROUND.saveChanges();
	}
}
