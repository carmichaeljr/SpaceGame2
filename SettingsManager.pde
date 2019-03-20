private class SettingsManager {
	private String fileName;
	private String[] rawData;

	public SettingsManager(String fileName){
		this.fileName=new String(fileName);
		this.rawData=loadStrings(this.fileName);
	}

	public String getSetting(String id){
		boolean _break=false;
		String rv=null;
		for (int i=0; i<this.rawData.length && !_break; i++){
			String[] temp=split(this.rawData[i],"=");
			if (temp[0].equalsIgnoreCase(id)){
				rv=temp[1];
				_break=true;
			}
		}
		return rv;
	}

	public void saveSetting(String id, String value){
		boolean _break=false;
		for (int i=0; i<this.rawData.length && !_break; i++){
			String[] temp=split(this.rawData[i],"=");
			if (temp[0].equalsIgnoreCase(id)){
				temp[1]=value;
				this.rawData[i]=String.format("%s=%s",temp[0],temp[1]);
				_break=true;
			}
		}
		saveStrings(this.fileName,this.rawData);
	}

	public void saveSettings(HashMap<String,String> settings){
		for (String iterKey: settings.keySet()){
			for (int i=0; i<this.rawData.length; i++){
				String[] temp=split(this.rawData[i],"=");
				if (iterKey.equalsIgnoreCase(temp[0])){
					temp[1]=settings.get(iterKey);
					this.rawData[i]=String.format("%s=%s",temp[0],temp[1]);
				}
			}
		}
		saveStrings(this.fileName,this.rawData);
	}
}
