private abstract class FlowField extends ScrollerPane {
	protected PVector[][] field;
	protected int cols, rows;
	protected float resolution;

	public FlowField(float resolution){
		super();
		this.resolution=resolution;
		this.cols=int(GAME_AREA.getSizeX()/resolution);
		this.rows=int(GAME_AREA.getSizeY()/resolution);
		//The flow field is a list of POLAR coordinates
		this.field=new PVector[this.cols][this.rows];
		this.generateField();
	}

	public void generateField(){
		for (int i=0; i<this.cols; i++){
			for (int j=0; j<this.rows; j++){
				PVector temp=this.generateFieldPVector(i,j);
				temp.x=constrain(temp.x,-this.resolution,this.resolution);
				this.field[i][j]=temp;
			}
		}
	}

	public PVector locate(PVector loc){
		int column=int(constrain((loc.x)/this.resolution,0,this.cols-1));
		int row=int(constrain((loc.y)/this.resolution,0,this.rows-1));
		return this.field[column][row].get();
	}

	@Override
	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		stroke(100);
		for (int i=0; i<this.cols; i++){
			for (int j=0; j<this.rows; j++){
				float arrowLength=this.resolution/4;
				PVector center=new PVector(i*this.resolution,j*this.resolution);
				PVector rightCord=new PVector((this.field[i][j].x*cos(this.field[i][j].y))/2,
							      (this.field[i][j].x*sin(this.field[i][j].y))/2);
				PVector leftCord=new PVector((this.field[i][j].x*cos(this.field[i][j].y+PI))/2,
							     (this.field[i][j].x*sin(this.field[i][j].y+PI))/2);
				rightCord.add(center);
				leftCord.add(center);
				PVector rightArrow=new PVector(rightCord.x-(arrowLength*sin(PI/4+field[i][j].y)),
							       rightCord.y+(arrowLength*cos(PI/4+field[i][j].y)));
				PVector leftArrow=new PVector(rightCord.x-(arrowLength*sin(PI/4-field[i][j].y)),
							      rightCord.y-(arrowLength*cos(PI/4-field[i][j].y)));
				line(rightCord.x,rightCord.y,leftCord.x,leftCord.y);
				line(rightCord.x,rightCord.y,rightArrow.x,rightArrow.y);
				line(rightCord.x,rightCord.y,leftArrow.x,leftArrow.y);
			}
		}
		popMatrix();
	}

	public abstract PVector generateFieldPVector(int x, int y);
}
