private abstract class ComponentContainer {
	protected ArrayList<InteractiveUIElement> interactiveComponents;
	protected ArrayList<UpdateInterface> updateComponents;
	protected ArrayList<DisplayInterface> displayComponents;
	protected ArrayList<ResetInterface> resetComponents;

	public ComponentContainer(){
		this.interactiveComponents=new ArrayList<InteractiveUIElement>();
		this.updateComponents=new ArrayList<UpdateInterface>();
		this.displayComponents=new ArrayList<DisplayInterface>();
		this.resetComponents=new ArrayList<ResetInterface>();
	}

	protected void addInteractiveComponent(InteractiveUIElement newElement){
		this.interactiveComponents.add(newElement);
	}
	protected void removeInteractiveComponent(InteractiveUIElement element){
		this.interactiveComponents.remove(element);
	}
	public ArrayList<InteractiveUIElement> getInteractiveComponents(){
		return this.interactiveComponents;
	}

	protected void addUpdateComponent(UpdateInterface newElement){
		this.updateComponents.add(newElement);
	}
	public void removeUpdateComponent(UpdateInterface element){
		this.updateComponents.remove(element);
	}
	public ArrayList<UpdateInterface> getUpdateComponents(){
		return this.updateComponents;
	}

	protected void addDisplayComponent(DisplayInterface newElement){
		this.displayComponents.add(newElement);
	}
	public void removeDisplayComponent(DisplayInterface element){
		this.displayComponents.remove(element);
	}
	public ArrayList<DisplayInterface> getDisplayComponents(){
		return this.displayComponents;
	}

	protected void addResetComponent(ResetInterface newElement){
		this.resetComponents.add(newElement);
	}
	public void removeResetComponent(ResetInterface element){
		this.resetComponents.remove(element);
	}
	public ArrayList<ResetInterface> getResetComponents(){
		return this.resetComponents;
	}
}
