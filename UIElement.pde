private abstract class UIElement implements DisplayInterface {
	protected PVector location;
	protected float _width;
	protected float _height;

	public UIElement(){
		this.location=new PVector();
		this._width=0;
		this._height=0;
	}

	public void setLocation(PVector location){
		this.location=location.get();
	}
	public PVector getLocation(){
		return this.location;
	}

	public void setSize(float _width, float _height){
		this._width=_width;
		this._height=_height;
	}

	public abstract void display();
}
