private class CAScrollPane extends ScrollerPane implements 
	UpdateInterface,DisplayInterface,DebugDisplayInterface {
	private ArrayList<ExplosionCA> cas;

	public CAScrollPane(){
		this.cas=new ArrayList<ExplosionCA>();
	}

	public void addCA(PVector loc){
		boolean add=true;
		for (int i=0; i<this.cas.size() && add; i++){
			if (PVector.dist(loc,this.cas.get(i).getLocation())<30){
				add=false;
			}
		}
		if (add){
			ExplosionCA temp=new ExplosionCA(40,40,1);
			temp.setLocation(PVector.sub(loc,new PVector(20,20)));
			temp.setLifeRate(4.2);
			this.cas.add(temp);
		}
	}

	@Override
	public void update(){
		super.update();
		Iterator<ExplosionCA> system=this.cas.iterator();
		while (system.hasNext()){
			CA2D ca=system.next();
			ca.update();
			if (ca.getPercentageAlive()<0.1){
				system.remove();
			}
		}
	}

	@Override
	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		for (CA2D iterCA: this.cas){
			iterCA.display();
		}
		popMatrix();
	}

	@Override
	public void displayDebug(){
		stroke(255,255,40);
		noFill();
		pushMatrix();
		translate(super.location.x,super.location.y);
		rect(GAME_AREA.getSizeX()/2,GAME_AREA.getSizeY()/2,
			GAME_AREA.getSizeX(),GAME_AREA.getSizeY());
		popMatrix();
	}
}
