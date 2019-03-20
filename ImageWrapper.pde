private class ImageWrapper extends UIElement {
	private PImage image;
	
	public ImageWrapper(String imagePath){
		this.image=loadImage(imagePath);
	}

	@Override
	public void setSize(float _width, float _height){
		this.image.resize((int)_width,(int)_height);
	}

	public float getHeight(){
		return this.image.height;
	}
	public float getWidth(){
		return this.image.width;
	}

	public void resizePorpotionally(char wOrH, float newDimension){
		float origDimension=(wOrH=='w' || wOrH=='W')? this.image.width: this.image.height;
		float porpotion=newDimension/origDimension;
		this.image.resize((int)(this.image.width*porpotion),
				  (int)(this.image.height*porpotion));
	}

	public void display(){
		pushMatrix();
		translate(super.location.x,super.location.y);
		image(this.image,0,0);
		popMatrix();
	}
}
