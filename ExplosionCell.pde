private class ExplosionCell extends Cell {
	public ExplosionCell(){
		super();
	}

	@Override
	public void display(){
		//stroke(255,255,40,map(this.generations,0,20,0,255));
		stroke(map(this.generations,0,5,255,100),
			map(this.generations,0,5,255,100),
			map(this.generations,0,5,40,0));
		point(this.x,this.y);
	}
}
