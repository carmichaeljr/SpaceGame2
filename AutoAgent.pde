private abstract class AutoAgent extends Mover {
	protected float maxForce;
	protected float maxSpeed;
	protected float time;

	public AutoAgent(){
		super();
		this.time=0;
		this.maxForce=5;
		this.maxSpeed=5;
	}

	public PVector getSeekForce(PVector target){
		PVector desired=PVector.sub(target,super.location);
		desired.normalize();
		desired.mult(this.maxSpeed);
		return this.applySteerForce(desired);
	}

	public PVector getSeekDesiredLocationForce(float theta){
		PVector futurePos=super.velocity.get();
		futurePos.normalize();
		futurePos.mult(40);
		futurePos.add(super.location);
		PVector seekPos=new PVector(10*cos(theta),10*sin(theta));
		seekPos.add(futurePos);
		return this.getSeekForce(seekPos);

		//line(super.location.x,super.location.y,futurePos.x,futurePos.y);
		//noFill();
		//ellipse(futurePos.x,futurePos.y,20,20);
		//fill(0);
		//ellipse(seekPos.x,seekPos.y,4,4);
	}

	public PVector getSeekRandomDesiredLocationForce(){
		if (super.velocity.mag()>0){
			this.time+=0.01;
			return this.getSeekDesiredLocationForce(map(noise(this.time),0,1,0,TWO_PI));
		}
		return new PVector();
	}

	public boolean seekSuccess(PVector target){
		float xDiff=abs(super.location.x-target.x);
		float yDiff=abs(super.location.y-target.y);
		if (xDiff<2 && yDiff<2){
			return true;
		}
		return false;
	}

	public PVector getFollowForce(FlowField flow){
		PVector temp=flow.locate(this.location);
		PVector desired=new PVector(temp.x*cos(temp.y),temp.x*sin(temp.y));
		desired.normalize();
		desired.mult(this.maxSpeed);
		return this.applySteerForce(desired);
	}

	//public PVector getFollowForce(Path path){
	//	PVector predict=this.velocity.get();
	//	predict.normalize();
	//	predict.mult(25);
	//	PVector predictLoc=PVector.add(this.location,predict);
	//	//noFill();
	//	//ellipse(predictLoc.x,predictLoc.y,10,10);

	//	PVector normalPoint=null;
	//	PVector target=null;
	//	float minDist=1000000;
	//	for (int i=0; i<path.getNumPoints()-1; i++){
	//		PVector a=path.getPoint(i);
	//		PVector b=path.getPoint(i+1);
	//		PVector tempNormalPoint=this.getNormalPoint(predictLoc,a,b);
	//		if (tempNormalPoint.x<min(a.x,b.x) || tempNormalPoint.x>max(a.x,b.x)){
	//			tempNormalPoint.x=b.x;
	//		}
	//		if (tempNormalPoint.y<min(a.y,b.y) || tempNormalPoint.y>max(a.y,b.y)){
	//			tempNormalPoint.y=b.y;
	//		}
	//		float dist=PVector.dist(predictLoc,tempNormalPoint);
	//		if (dist<minDist){
	//			normalPoint=tempNormalPoint.get();
	//			PVector dir=PVector.sub(b,a);
	//			dir.normalize();
	//			dir.mult(10);
	//			target=PVector.add(normalPoint,dir);
	//			minDist=dist;
	//		}
	//	}
	//	
	//	//fill(0);
	//	//line(predictLoc.x,predictLoc.y,normalPoint.x,normalPoint.y);
	//	float distance=PVector.dist(normalPoint,predictLoc);
	//	if (distance>path.getRadius()){
	//		return this.getSeekForce(target);
	//		//fill(100,0,0);
	//	}
	//	return new PVector();
	//	//ellipse(normalPoint.x,normalPoint.y,10,10);
	//	//ellipse(target.x,target.y,10,10);
	//}

	public PVector getArriveForce(PVector target){
		PVector desired=PVector.sub(target,super.location);
		float d=desired.mag();
		desired.normalize();
		if (d<100){
			float m=map(d,0,100,0,this.maxSpeed);
		} else {
			desired.mult(this.maxSpeed);
		}
		return this.applySteerForce(desired);
	}

	public PVector getAvoidForce(PVector target){
		PVector undesired=PVector.sub(target,super.location);
		undesired.normalize();
		undesired.mult(-this.maxSpeed);
		return this.applySteerForce(undesired);
	}

	public PVector getAvoidAllForce(ArrayList<PVector> locations){
		PVector sumAvoidForce=new PVector();
		for (PVector loc: locations){
			sumAvoidForce.add(this.getAvoidForce(loc));
		}
		return sumAvoidForce;
	}

	public PVector getAvoidAllInRadiusForce(ArrayList<PVector> locations, int radius){
		PVector sumAvoidForce=new PVector();
		for (PVector loc: locations){
			if (dist(super.location.x,super.location.y,loc.x,loc.y)<radius){
				sumAvoidForce.add(this.getAvoidForce(loc));
			}
		}
		return sumAvoidForce;
	}

	//Group behaviors
	public PVector getSeparateForce(ArrayList<Mover> vehicles){
		float desiredSeparation=super.mass*2;
		PVector sum=new PVector();
		int count=0;
		for (Mover other: vehicles){
			float dist=PVector.dist(super.location,other.getLocation());
			if (dist>0 && dist<desiredSeparation){
				PVector diff=PVector.sub(super.location,other.getLocation());
				diff.normalize();
				diff.div(dist);
				sum.add(diff);
				count++;
			}
		}
		if (count>0){
			sum.div(count);
			sum.normalize();
			sum.mult(this.maxSpeed);
			sum=this.applySteerForce(sum);
		}
		return sum;
	}

	public PVector getCohesionForce(ArrayList<Mover> vehicles){
		float desiredSeparation=super.mass*2;
		PVector sum=new PVector();
		int count=0;
		for (Mover other: vehicles){
			float dist=PVector.dist(super.location,other.getLocation());
			if (dist>0 && dist>desiredSeparation){
				PVector diff=PVector.sub(super.location,other.getLocation());
				diff.normalize();
				diff.div(dist);
				sum.add(diff);
				count++;
			}
		}
		if (count>0){
			sum.div(count);
			sum.normalize();
			sum.mult(-this.maxSpeed);
			sum=this.applySteerForce(sum);
		}
		return sum;
	}

	public PVector getCenterCohesionForce(ArrayList<Mover> vehicles){
		float desiredSeparation=super.mass*2;
		PVector sum=new PVector();
		int count=0;
		for (Mover other: vehicles){
			float dist=PVector.dist(super.location,other.getLocation());
			if (dist>0 && dist>desiredSeparation){
				sum.add(other.getLocation());
				count++;
			}
		}
		if (count>0){
			sum.div(count);
			sum=this.getSeekForce(sum);
		}
		return sum;
	}

	public PVector getAlignForce(ArrayList<Mover> vehicles){
		PVector sum=new PVector();
		int count=0;
		float radius=50;
		for (Mover other: vehicles){
			float dist=PVector.dist(super.location,other.getLocation());
			float theta=atan2(other.getLocation().y-super.location.y,
					  other.getLocation().x-super.location.x);
			if (dist>0 && dist<radius && theta>-HALF_PI && theta <HALF_PI){
				sum.add(other.getVelocity());
				count++;
			}
		}
		if (count>0){
			sum.div(count);
			sum.normalize();
			sum.mult(this.maxSpeed);
			return this.applySteerForce(sum);
		}
		return new PVector();
	}

	protected PVector applySteerForce(PVector desiredLoc){
		PVector steer=PVector.sub(desiredLoc,super.velocity);
		steer.limit(this.maxForce);
		return steer;
	}

	protected PVector getNormalPoint(PVector p, PVector a, PVector b){
		PVector ap=PVector.sub(p,a);
		PVector ab=PVector.sub(b,a);
		ab.normalize();
		ab.mult(ap.dot(ab));
		PVector normalPoint=PVector.add(a,ab);
		return normalPoint;
	}
}
