private abstract class CA2D extends Mover {
	protected Cell[][] grid;
	protected int resolution;
	protected int columns;
	protected int rows;
	protected int width;
	protected int height;
	protected float lifeRate;
	protected float deathRate;

	public CA2D(int width, int height, int resolution){
		this.resolution=resolution;
		this.height=height;
		this.width=width;
		this.columns=this.height/this.resolution;
		this.rows=this.width/this.resolution;
		this.grid=new Cell[this.columns][this.rows];
		this.lifeRate=3;
		this.deathRate=0.1;
		this.generateInitial();
	}

	public float getLifeRate(){
		return this.lifeRate;
	}
	public void setLifeRate(float lifeRate){
		this.lifeRate=constrain(lifeRate,3,4);
	}

	public float getPercentageAlive(){
		int aliveCount=0;
		for (Cell[] iterCellList: this.grid){
			for (Cell iterCell: iterCellList){
				if (iterCell.getState()>0){
					aliveCount++;
				}
			}
		}
		return (float)aliveCount/(this.grid.length*this.grid[0].length);
	}
	//public float getDeathRate(){
	//	return this.deathRate;
	//}
	//public void setDeathRate(float deathRate){
	//	this.deathRate=constrain(deathRate,0,0.1);
	//}

	public void generateInitial(){
		for (int i=0; i<this.grid.length; i++){
			for (int j=0; j<this.grid[i].length; j++){
				//this.grid[i][j]=new Cell();
				this.grid[i][j]=this.generateNewCell();
				this.grid[i][j].setState(int(random(2)));
				this.grid[i][j].setPosition(new PVector(j*this.resolution,i*this.resolution));
				this.grid[i][j].setWidth(this.resolution);
			}
		}
	}

	public void setInitialStates(){
		for (Cell[] iterCellList: this.grid){
			for (Cell iterCell: iterCellList){
				iterCell.setState(int(random(2)));
				iterCell.setGenerations(0);
			}
		}
	}

	public void update(){
		float neighbors=0;
		for (Cell[] iterCellList: this.grid){
			for (Cell iterCell: iterCellList){
				iterCell.update();
			}
		}
		for (int i=0; i<this.columns; i++){
			for (int j=0; j<this.rows; j++){
				neighbors=this.getNeighbors(j,i);
				if (this.grid[i][j].getPreviousState()>0 && neighbors<(this.lifeRate-1)){
					this.grid[i][j].setState(this.grid[i][j].getPreviousState()-this.deathRate);
				} else if (this.grid[i][j].getPreviousState()>0 && neighbors>(this.lifeRate)){
					this.grid[i][j].setState(this.grid[i][j].getPreviousState()-this.deathRate);
				} else if (this.grid[i][j].getPreviousState()==0 && (neighbors>(this.lifeRate-1) && neighbors<this.lifeRate)){
					this.grid[i][j].setState(1);
				}
			}
		}
		//this.checkForLifeRateChange();
	}
	
	private float getNeighbors(int origCellX,int origCellY){
		float neighbors=0;
		for (int k=-1; k<2; k++){
			for (int m=-1; m<2; m++){
				//int y=constrain(k+origCellY,0,this.grid.length-1);
				//int x=constrain(m+origCellX,0,this.grid[0].length-1);
				int y=k+origCellY;
				int x=m+origCellX;
				if (y>=this.grid.length){
					y-=this.grid.length;
				} else if (y<0){
					y+=this.grid.length;
				}
				if (x>=this.grid[y].length){
					x-=this.grid[y].length;
				} else if (x<0){
					x+=this.grid[y].length;
				}
				neighbors+=this.grid[y][x].getPreviousState();
			}
		}
		neighbors-=this.grid[origCellY][origCellX].getPreviousState();
		return neighbors;
	}

	public void checkForLifeRateChange(){
		int aliveCount=0;
		for (Cell[] iterCellList: this.grid){
			for (Cell iterCell: iterCellList){
				if (iterCell.getState()>0){
					aliveCount++;
				}
			}
		}
		if (aliveCount==0){
			this.setInitialStates();
		} else if (aliveCount<(this.grid.length*this.grid[0].length)*0.2){
			this.setLifeRate(this.lifeRate-0.01);
		} else if (aliveCount<(this.grid.length*this.grid[0].length)*0.6){
			this.setLifeRate(this.lifeRate+0.01);
		}
	}

	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		for (Cell[] iterCellList: this.grid){
			for (Cell iterCell: iterCellList){
				iterCell.display();
			}
		}
		popMatrix();
	}

	protected abstract Cell generateNewCell();
}

