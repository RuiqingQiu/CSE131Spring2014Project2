//---------------------------------------------------------------------
//
//---------------------------------------------------------------------

class VarSTO extends STO
{
	
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public 
	VarSTO (String strName)
	{
		super (strName);
		// You may want to change the isModifiable and isAddressable 
		// fields as necessary
		this.isStatic = false;
		
		this.isNegative = false;
		this.passByValueHoldAddress = false;
	}

	public 
	VarSTO (String strName, Type typ)
	{
		super (strName, typ);
		// You may want to change the isModifiable and isAddressable 
		// fields as necessary
		this.isStatic = false;
		this.isNegative = false;
		this.passByValueHoldAddress = false;

	}

	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public boolean   
	isVar () 
	{
		return true;
	}
	public STO getInit(){
		return init;
	}
	public void setInit(STO init){
		this.init = init;
	}
	
	public boolean isStatic(){
		return this.isStatic;
	}
	public void setStatic(boolean b){
		this.isStatic = b;
	}
	public boolean isNegative(){
		return this.isNegative;
	}
	public void setNegative(boolean b){
		this.isNegative = b;
	}
	public void setPassByValueHoldAddress(boolean b){
		this.passByValueHoldAddress = b;
	}
	public boolean getPassByValueHoldAddress(){
		return this.passByValueHoldAddress;
	}

	private STO init;
	private boolean isStatic;
	
	private boolean isNegative;
	
	private boolean passByValueHoldAddress;
}
