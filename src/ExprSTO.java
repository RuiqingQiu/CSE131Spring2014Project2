//---------------------------------------------------------------------
//
//---------------------------------------------------------------------

class ExprSTO extends STO
{
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public 
	ExprSTO (String strName)
	{
		super (strName);
                // You may want to change the isModifiable and isAddressable                      
                // fields as necessary
		this.HoldAddress = false;
	}

	public 
	ExprSTO (String strName, Type typ)
	{
		super (strName, typ);
                // You may want to change the isModifiable and isAddressable                      
                // fields as necessary
		this.HoldAddress = false;
	}

	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public boolean
	isExpr ()
	{
		return	true;
	}
	public void setHoldAddress(boolean b){
		this.HoldAddress = b;
	}
	public boolean getHoldAddress(){
		return this.HoldAddress;
	}
	//This is for indicating whether this ExprSTO's base & offset is 
	//holding an address rather than an actual value
	private boolean HoldAddress;
}
