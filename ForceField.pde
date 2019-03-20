private class ForceField extends Mover implements UpdateInterface, DisplayInterface{
	private color _color;
	private float radius;
	private int effectiveness;
	private int presetDincrement;

	public ForceField(){
		this._color=color(0);
		this.radius=0;
		this.effectiveness=255;
		this.presetDincrement=0;
	}

	public void setRadius(float radius){
		this.radius=radius;
	}

	public void setColor(color c){
		this._color=c;
	}

	public void setDincrement(int dec){
		this.presetDincrement=dec;
	}

	public void setEffectiveness(int newEff){
		int diff=this.effectiveness-newEff;
		this.effectiveness=newEff;
		this._color=color(red(this._color)-diff,green(this._color)-diff,blue(this._color)-diff);
	}
	public int getEffectiveness(){
		return this.effectiveness;
	}

	public void dincrementEffectivness(){
		this.effectiveness-=this.presetDincrement;
		this._color=color(red(this._color)-this.presetDincrement,green(this._color)-this.presetDincrement,blue(this._color)-this.presetDincrement);
	}

	public void display(){
		noFill();
		for (int i=0; i<5; i++){
			stroke(red(this._color)-i*51,green(this._color)-i*51,blue(this._color)-i*51,255-i*51);
			ellipse(super.location.x,super.location.y,(this.radius+i)*2,(this.radius+i)*2);
		}
	}
}
