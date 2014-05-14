
public class IncOp extends UnaryOp {
	public IncOp(String postOrPre){
		this.postOrPre = postOrPre;
	}
	@Override
	STO checkOperands(STO a) {
		Type aType = a.getType();
		Type tmp = aType.clone();
		tmp.setReference(false);
		if (aType.isNumeric()) {
			if(a.getIsAddressable() == true && a.getIsModifiable() == true){				
				return new ExprSTO(this.postOrPre, tmp);
			}
			else
				return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Lval,  "++"));
		} 
		else if(aType.isPointer()){
			if(!(a.isModLValue())){
				return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Lval,  "++"));
			}
			//check if aType is a functptr type
			if(aType.isFuncPointer()){
				return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Type, aType.getName(), "++"));
			}
		    return new ExprSTO(this.postOrPre, tmp);
		}
		else{
			return new ErrorSTO(Formatter.toString(ErrorMsg.error2_Type, aType.getName(), "++"));
		}
	}
	private String postOrPre = "";
	

}
