private void showSplashScreen(){
	fill(0);
	rect(width/2,height/2,width,height);

	//rocket
	pushMatrix();
	translate(width/4,height/4);
	rotate(-PI/6);
	fill(100);
	noStroke();
	quad(0,0,40,-40,0,40,-40,-40);
	popMatrix();
	
	//bullets
	pushMatrix();
	translate(width/4,height/4);
	rotate(PI/6);
	fill(255,0,0);
	noStroke();
	for (int i=0;i<30; i++){
	  ellipse(20*i+50,-pow(i-3,2)+40,20-i,20-i);
	}
	popMatrix();

	//oponents
	float scale=100;
	ArrayList<PVector> locs=new ArrayList<PVector>();
	locs.add(new PVector(width/2-20,height/2));
	locs.add(new PVector(width*0.75,height*0.25));
	locs.add(new PVector(width-50,height-100));
	for (int i=0; i<locs.size(); i++){
	  fill(255);
	  ellipse(locs.get(i).x,locs.get(i).y-scale/4,scale/2,scale/3);
	  ellipse(locs.get(i).x,locs.get(i).y,scale,scale/2);
	  fill(0);
	  ellipse(locs.get(i).x-scale/4,locs.get(i).y,scale/5,scale/5);
	  ellipse(locs.get(i).x,locs.get(i).y,scale/5,scale/5);
	  ellipse(locs.get(i).x+scale/4,locs.get(i).y,scale/5,scale/5);
	}
	
	//text
	fill(255,0,0);
	textSize(100);
	text("Space Game 2",width/2-textWidth("Space Game 2")/2,height-25);
}
