private interface UpdateInterface {
	public void update();
}
private interface DisplayInterface {
	public void display();
}
private interface ResetInterface {
	public void reset();
}

private interface CollisionDetection {
	public boolean collided(Mover other);
	public void performCollisionAction(String ... otherID);
}

private interface KeyboardActionInterface {
	public void performKeyboardAction(String ... args);
}

private interface MouseActionInterface {
	public void performMouseAction(String ... args);
}

private interface ButtonActionInterface {
	public void performButtonAction(String ... args);
}

private interface DebugDisplayInterface {
	public void displayDebug();
}
