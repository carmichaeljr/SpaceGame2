private class SideMenu extends UIElement implements DisplayInterface {
	private color menuColor;

	public SideMenu(){
		super();
	}
	
	public void setMenuColor(color c){
		this.menuColor=c;
	}
	public color getMenuColor(){
		return this.menuColor;
	}

	@Override
	public void display(){
		noFill();
		stroke(this.menuColor);
		strokeWeight(3);
		rect(super.location.x,super.location.y,super._width,super._height);
		strokeWeight(1);
	}
}
