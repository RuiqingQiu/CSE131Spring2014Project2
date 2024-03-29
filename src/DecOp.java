
public class DecOp extends UnaryOp{
	public DecOp(String postOrPre){
		this.postOrPre = postOrPre;
	}
	@Override
	STO checkOperands(STO a) {
		Type aType = a.getType();
		Type tmp = aType.clone();
		tmp.setReference(false);
		//Check operand is numeric type
		if (aType.isNumeric()) {
			//get if the operand is a modifiable L-value
			if(a.getIsAddressable() == true && a.getIsModifiable() == true)
				return new ExprSTO(this.postOrPre, tmp);
			else
				return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Lval,  "--"));		
		}
		else if(aType.isPointer()){
			if(!(a.isModLValue())){
				return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Lval,  "--"));
			}
			//check if aType is a funcptr type
			if(aType.isFuncPointer()){
				return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Type, aType.getName(), "--"));
			}
			return new ExprSTO(this.postOrPre, tmp);
		}
		else{
			return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Type, aType.getName(), "--"));
		}
	}
	private String postOrPre = "";
}
