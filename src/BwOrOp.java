
public class BwOrOp extends BitwiseOp{
	STO checkOperands(STO a, STO b) {
		Type aType = a.getType();
		Type bType = b.getType();
		//Both operands must be bool type
		if (aType.isInt() && bType.isInt()) {
			if(a.isConst() && b.isConst()){
				int x = ((ConstSTO)a).getIntValue() | ((ConstSTO)b).getIntValue();
				ConstSTO c = new ConstSTO("", new IntType("int", 4));
				c.setValue(x);
				return c;
			}
			return new ExprSTO("BwOrOp", new IntType("int", 4));
		}
		else {
			// error
			if(!(aType.isInt()))
				return new ErrorSTO(Formatter.toString(ErrorMsg.error1w_Expr,aType.getName(), "|", "int"));
			else
				return new ErrorSTO(Formatter.toString(ErrorMsg.error1w_Expr,bType.getName(), "|", "int"));
		} 
	}
}
