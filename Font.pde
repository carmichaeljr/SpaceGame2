private abstract class Font extends UIElement implements DisplayInterface {
	private PFont font;
	private color _color;
	private String fontName;
	private int fontSize;
	private float fontScalar;
	private float textHeight;
	
	public Font(String fontName, int fontSize){
		super();
		this.fontName=fontName;
		this.fontSize=fontSize;
		this.fontScalar=1;
		this._color=color(0);
		this.initilizeFont();
	}
	
	public void setColor(color c){
		this._color=c;
	}
	public color getColor(){
		return this._color;
	}

	public void setFontSize(int newSize){
		this.fontSize=newSize;
		this.initilizeFont();
	}
	
	public void setFontName(String newFont){
		this.fontName=newFont;
		this.initilizeFont();
	}
	
	public float getFontWidth(String text){
		return textWidth(text);
	}
	
	public float getFontScalar(){
		return this.fontScalar;
	}
	
	public void setFontScalar(float fontScalar){
		if(fontScalar>0){
			this.fontScalar=fontScalar;
		}
		this.calculateTextHeight();
	}
	
	private void initilizeFont(){
		this.font=loadFont(this.fontName);
		this.setFont();
		this.calculateTextHeight();
	}
	
	protected void setFont(){
		textFont(this.font);
		textSize(this.fontSize);
	}
	
	public void calculateTextHeight(){
		this.textHeight=(textAscent()+textDescent())*this.fontScalar;
	}
	
	public abstract void display();
}
