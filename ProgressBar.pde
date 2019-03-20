private class ProgressBar extends UIElement {
	private MenuDisplayFont description;
	private color barColor;
	private color backgroundColor;
	private float percentage;

	public ProgressBar(){
		super();
		this.description=new MenuDisplayFont(10);
		this.description.setLocation(super.location);
		this.barColor=color(255);
		this.percentage=100;
	}

	@Override
	public void setLocation(PVector loc){
		super.setLocation(loc);
		this.updateDescription();
	}

	@Override
	public void setSize(float _width, float _height){
		super.setSize(_width,_height);
		this.updateDescription();
	}

	public void setPercentage(float percentage){
		this.percentage=percentage;
	}

	public void setColor(color c){
		this.barColor=c;
	}

	public void setBackgroundColor(color c){
		this.backgroundColor=c;
	}

	public void setTextColor(color c){
		this.description.setColor(c);
	}

	public void setDescription(String dec){
		this.description.setDisplayText(dec);
		this.updateDescription();
	}

	private void updateDescription(){
		this.description.setFontSize((int)super._height-4);
		PVector loc=super.location.get();
		loc.x-=this.description.getTextWidth()/2;
		loc.y+=super._height/2-2;
		this.description.setLocation(loc);
	}

	public void display(){
		float barLength=super._width*this.percentage;
		pushMatrix();
		translate(super.location.x,super.location.y);
		noStroke();
		fill(this.backgroundColor);
		rect(0,0,super._width,super._height);
		fill(this.barColor);
		rect(-super._width/2+barLength/2,0,barLength,super._height);
		popMatrix();
		this.description.display();
	}
}
