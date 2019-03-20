private class Trees extends ScrollerPane implements UpdateInterface,DisplayInterface{
	private ArrayList<Tree> trees;
	private Ground groundRef;
	private int numTrees;

	public Trees(){
		super();
		this.trees=new ArrayList<Tree>();
		this.numTrees=int(GAME_AREA.getSizeX()/500);
	}

	public void setGroundRef(Ground ground){
		this.groundRef=ground;
	}

	public void populateTrees(){
		if (this.groundRef!=null){
			for (int i=0; i<this.numTrees; i++){
				this.addTree();
			}
		}
	}

	private void addTree(){
		float xLoc=random(0,GAME_AREA.getSizeX());
		PVector loc=new PVector(xLoc,this.groundRef.getGroundCoordinate(xLoc)+10);
		Tree temp=new Tree(random(5,10),random(PI/15,PI/5));
		temp.setMaxLen(random(50,100));
		temp.setGrowthRate(random(0.01,0.05));
		temp.setLocation(loc);
		this.trees.add(temp);
	}

	@Override
	public void update(){
		super.update();
		for (Tree iterTree: this.trees){
			iterTree.update();
		}
	}

	@Override
	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		for (Tree iterTree: this.trees){
			if (abs(-super.location.x+width/2-iterTree.getLocation().x)<width/2+50){
				if (DEBUG){ 
					stroke(0,255,0);
				} else {
					stroke(100);
				}
				iterTree.display();
			} else if (DEBUG) {
				stroke(255,0,0);
				iterTree.display();
			}
		}
		popMatrix();
	}
}
