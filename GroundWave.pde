private class GroundWave {
	private ArrayList<Wave> waveSumation;
	private float groundGranularity;
	private float screenHeight;
	private float startAngle;
	private float time;

	public GroundWave(float startAngle, float height) {
		this.waveSumation=new ArrayList<Wave>();
		this.startAngle=startAngle;
		this.screenHeight=height;
		this.groundGranularity=1;
		this.time=random(0,1000);
	}

	public void setScreenHeight(float newScreenHeight){
		this.screenHeight=newScreenHeight;
	}
	public float getScreenHeight(){
		return this.screenHeight;
	}

	public void setGroundGranularity(float newGG){
		this.groundGranularity=newGG;
	}
	public float getGroundGranularity(){
		return this.groundGranularity;
	}

	public float getStartAngle(){
		return this.startAngle;
	}

	public void appendWave(float amplitude, float period){
		Wave wave=new Wave();
		wave.setAmplitude(amplitude);
		wave.setPeriod(period);
		this.waveSumation.add(wave);
	}

	public float getYValueSum(float angle){
		float rv=0;
		for (Wave iterWave: this.waveSumation){
			rv+=iterWave.getYValue(angle+this.startAngle);
		}
		rv+=map(noise(this.time+(0.05*angle)),0,1,0,this.groundGranularity*2);
		//rv+=map(noise(this.time+angle),0,1,0,this.groundGranularity/2);
		return rv;
	}

	public float getGroundCoordinate(float xCoord){
		float angle=this.startAngle+xCoord;
		return this.screenHeight+this.getYValueSum(angle);
	}
}

