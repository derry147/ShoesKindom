package uuu.s2k.entity;

public class Size_list{
	
	private String sizeCode;

	public String getSizeCode() {
		return sizeCode;
	}

	public void setSizeCode(String sizeCode) {
		this.sizeCode = sizeCode;
	}

	@Override
	public String toString() {
		return "尺寸=" + sizeCode ;
	}
}
