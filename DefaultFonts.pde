private class ButtonFont extends Font {
	private static final String fontName="AgencyFB-Bold-150.vlw";
	private String buttonText;
	
	public ButtonFont(int fontSize){
		super(ButtonFont.fontName,fontSize);
		this.buttonText=new String();
	}
	
	public String getDisplayText(){
		return this.buttonText;
	}
	public void setDisplayText(String displayText){
		this.buttonText=displayText;
	}
	
	@Override
	public void display(){
		super.setFont();
		pushMatrix();
		translate(super.location.x,super.location.y);
		fill(super.getColor());
		text(this.buttonText,0,0);
		popMatrix();
	}
}


private class MenuDisplayFont extends Font {
	private static final String fontName="AgencyFB-Bold-150.vlw";
	private String displayTextFormat;
	private String displayText;
	
	public MenuDisplayFont(int fontSize){
		super(MenuDisplayFont.fontName,fontSize);
		this.displayTextFormat=new String();
		this.displayText=new String();
		this.displayTextFormat="%s";
	}
	
	public String getDisplayText(){
		return this.displayText;
	}
	public void setDisplayText(Object ... args){
		try {
			this.displayText=String.format(this.displayTextFormat,args);
		} catch (IllegalFormatConversionException e){
			print("Given arguments do not match formatting. ");
			println("Display Formating: "+this.displayTextFormat);
		}
	}
	
	public String getDisplayTextFormat(){
		return this.displayTextFormat;
	}
	public void setDisplayTextFormat(String newFormat){
		this.displayTextFormat=newFormat;
	}

	public float getTextWidth(){
		super.setFont();
		return textWidth(this.displayText);
	}
	
	@Override
	public void display(){
		super.setFont();
		pushMatrix();
		translate(super.location.x,super.location.y);
		fill(super.getColor());
		text(this.displayText,0,0);
		popMatrix();
	}
}

private class TickerFont extends Font implements UpdateInterface {
	private static final String fontName="AgencyFB-Bold-150.vlw";
	private String[] oldDisplayText;
	private String[] displayText;
	private int[] increment;
	private color backgroundColor;

	public TickerFont(int fontSize){
		super(TickerFont.fontName,fontSize);
		this.oldDisplayText=new String[2];
		this.displayText=new String[2];
		this.increment=new int[2];
		for (int i=0; i<2; i++){
			this.oldDisplayText[i]="00";
			this.displayText[i]="00";
			this.increment[i]=0;
		}
		this.backgroundColor=color(255);
	}

	public void setBackgroundColor(color c){
		this.backgroundColor=c;
	}

	public void setDisplayText(int time){
		int[] oldTimes=new int[]{
			Integer.parseInt(this.displayText[0]),
			Integer.parseInt(this.displayText[1])
		};
		int[] newTimes=new int[]{time/60,time%60};
		for (int i=0; i<2; i++){
			if (oldTimes[i]!=newTimes[i]){
				this.oldDisplayText[i]=this.displayText[i];
				this.displayText[i]=String.format("%02d",newTimes[i]);
				this.increment[i]=0;
			}
		}
	}
	public String[] getDisplayText(){
		return this.displayText;
	}

	public void update(){
		for (int i=0; i<2; i++){
			this.increment[i]=(int)constrain(this.increment[i]+1,0,super.textHeight);
		}
	}

	public void display(){
		super.setFont();
		pushMatrix();
		translate(super.location.x,super.location.y);
		fill(super._color);
		text(this.oldDisplayText[0],-40,this.increment[0]+10);
		text(this.displayText[0],-40,this.increment[0]-super.textHeight);
		text(":",0,0);
		text(this.oldDisplayText[1],10,this.increment[1]+10);
		text(this.displayText[1],10,this.increment[1]-super.textHeight);
		noStroke();
		fill(this.backgroundColor);
		rect(0,-super.textHeight*1.5-6,300,super.textHeight);
		rect(0,super.textHeight*0.5+5,300,super.textHeight+11);
		popMatrix();
	}
}
