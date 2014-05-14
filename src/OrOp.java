
public class OrOp extends BooleanOp {

	@Override
	STO checkOperands(STO a, STO b) {
		Type aType = a.getType();
		Type bType = b.getType();
		//Both operands must be bool type
		if (aType.isBool() && bType.isBool()) {
			if(a.isConst() && b.isConst()){
				ConstSTO c = new ConstSTO("OrOp", new BoolType("bool", 4));
				if(((ConstSTO)a).getBoolValue() || ((ConstSTO)b).getBoolValue())
					c.setValue(1.0);
				else
					c.setValue(0.0);
				return c;
			}
			return new ExprSTO("OrOp", new BoolType("bool", 4));
		}
		else {
			// error
			if(!(aType.isBool()))
				return new ErrorSTO(Formatter.toString(ErrorMsg.error1w_Expr,aType.getName(), "||", "bool"));
			else
				return new ErrorSTO(Formatter.toString(ErrorMsg.error1w_Expr,bType.getName(), "||", "bool"));
		} 
	}

}
