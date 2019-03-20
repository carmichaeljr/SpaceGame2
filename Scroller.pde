private abstract class Scroller extends Mover {
	protected ArrayList<ScrollerPane> attachments;
	protected PVector locationWithoutScroll;

	public Scroller(){
		super();
		this.attachments=new ArrayList<ScrollerPane>();
		this.locationWithoutScroll=new PVector();
	}

	public ArrayList<ScrollerPane> getAttachments(){
		return this.attachments;
	}
	public void addAttachment(ScrollerPane attachment){
		this.attachments.add(attachment);
	}

	@Override
	public void update(){
		super.velocity.add(super.acceleration);
		this.locationWithoutScroll.add(super.velocity);
		super.location.y+=super.velocity.y;
		super.thetaVelocity+=super.thetaAcceleration;
		super.theta+=super.thetaVelocity;
		for (ScrollerPane attachment: this.attachments){
			attachment.applyScroll(new PVector(-super.velocity.x,0));
		}
		super.acceleration.mult(0);
		super.thetaAcceleration=0;
	}

	public abstract void display();
}

private abstract class ScrollerPane extends Mover {
	protected PVector locWithoutScroll;

	public ScrollerPane(){
		super();
		this.locWithoutScroll=new PVector();
	}

	public void setLocWithoutScroll(PVector locWithoutSpring){
		this.locWithoutScroll=locWithoutSpring;
	}
	public PVector getLocWithoutScroll(){
		return this.locWithoutScroll;
	}

	public void applyScroll(PVector scroll){
		super.location.add(scroll);
	}

	@Override
	public void update(){
		super.update();
		this.locWithoutScroll.add(super.velocity);
	}

	public abstract void display();
}
