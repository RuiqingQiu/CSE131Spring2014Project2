
public class MinusOp extends ArithmeticOp{

	@Override
	STO checkOperands(STO a, STO b) {
		Type aType = a.getType();
		Type bType = b.getType();
		if(!aType.isNumeric())
			return new ErrorSTO(Formatter.toString(ErrorMsg.error1n_Expr,aType.getName(), "-"));
		else if(!bType.isNumeric())
			return new ErrorSTO(Formatter.toString(ErrorMsg.error1n_Expr,bType.getName(), "-"));
		else if (aType.isInt() && bType.isInt()) {
			if(a.isConst() && b.isConst()){
				int x = ((ConstSTO)a).getIntValue() - ((ConstSTO)b).getIntValue();
				ConstSTO c = new ConstSTO("", new IntType("int", 4));
				c.setValue(x);
				return c;
			}
			//Calculate the value of two Ints
			return new ExprSTO("MinusOp", new IntType("int", 4));
		} else {
			if(a.isConst() && b.isConst()){
				float x =  ((ConstSTO)a).getFloatValue() - ((ConstSTO)b).getFloatValue();
				ConstSTO c = new ConstSTO("", new FloatType("float", 4));
				
				c.setValue(x);
				return c;
			}
			return new ExprSTO("MinusOp", new FloatType("float", 4));
		}
	}

}
