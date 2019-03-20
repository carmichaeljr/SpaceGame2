private class ExplosionCA extends CA2D {
	private float radius;
	private float time;

	public ExplosionCA(int width, int height, int resolution){
		super(width,height,resolution);
		this.radius=10;
		this.time=0;
	}

	@Override
	protected Cell generateNewCell(){
		return new ExplosionCell();
	}

	@Override
	public void update(){
		super.update();
		//this.radius=-0.01*(this.time*this.time-2)+0.6*this.time+10;
		this.radius=20*sin(this.time/1000+log(this.time+1)/log(4));
		this.time+=1;
	}

	@Override
	public void display(){
		pushMatrix();
		blendMode(ADD);
		translate(super.location.x,super.location.y);
		for (int i=0; i<this.grid.length; i++){
			for (int j=0; j<this.grid[i].length; j++){
				if (dist(i*this.resolution,j*this.resolution,this.columns/2,this.rows/2)<this.radius){
					this.grid[i][j].display();
				}
			}
		}
		blendMode(NORMAL);
		popMatrix();
	}
}
