private class ComponentManager<T extends ComponentContainer> {
	protected T componentContRef;

	public ComponentManager(T componentContRef){
		this.componentContRef=componentContRef;
	}

	public void update(){
		for (UpdateInterface iterElement: this.componentContRef.getUpdateComponents()){
			iterElement.update();
		}
	}

	public void display(){
		//All components are displayed in the order of the array
		ArrayList<DisplayInterface> temp=this.componentContRef.getDisplayComponents();
		for (int i=0; i<temp.size(); i++){
			temp.get(i).display();
		}
	}

	public void reset(){
		for (ResetInterface iterElement: this.componentContRef.getResetComponents()){
			iterElement.reset();
		}
	}
}
