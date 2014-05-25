
//---------------------------------------------------------------------
//
//---------------------------------------------------------------------

import java_cup.runtime.*;

import java.util.Stack;
import java.util.Vector;



class MyParser extends parser
{

	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public 
	MyParser (Lexer lexer, ErrorPrinter errors)
	{
		m_lexer = lexer;
		m_symtab = new SymbolTable ();
		m_errors = errors;
		m_nNumErrors = 0;
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public boolean
	Ok ()
	{
		return (m_nNumErrors == 0);
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public Symbol
	scan ()
	{
		Token		t = m_lexer.GetToken ();

		//	We'll save the last token read for error messages.
		//	Sometimes, the token is lost reading for the next
		//	token which can be null.
		m_strLastLexeme = t.GetLexeme ();

		switch (t.GetCode ())
		{
			case sym.T_ID:
			case sym.T_ID_U:
			case sym.T_STR_LITERAL:
			case sym.T_FLOAT_LITERAL:
			case sym.T_INT_LITERAL:
			case sym.T_CHAR_LITERAL:
				return (new Symbol (t.GetCode (), t.GetLexeme ()));
			default:
				return (new Symbol (t.GetCode ()));
		}
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public void
	syntax_error (Symbol s)
	{
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public void
	report_fatal_error (Symbol s)
	{
		m_nNumErrors++;
		if (m_bSyntaxError)
		{
			m_nNumErrors++;

			//	It is possible that the error was detected
			//	at the end of a line - in which case, s will
			//	be null.  Instead, we saved the last token
			//	read in to give a more meaningful error 
			//	message.
			m_errors.print (Formatter.toString (ErrorMsg.syntax_error, m_strLastLexeme));
		}
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public void
	unrecovered_syntax_error (Symbol s)
	{
		report_fatal_error (s);
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public void
	DisableSyntaxError ()
	{
		m_bSyntaxError = false;
	}

	public void
	EnableSyntaxError ()
	{
		m_bSyntaxError = true;
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public String 
	GetFile ()
	{
		return (m_lexer.getEPFilename ());
	}

	public int
	GetLineNum ()
	{
		return (m_lexer.getLineNumber ());
	}

	public void
	SaveLineNum ()
	{
		m_nSavedLineNum = m_lexer.getLineNumber ();
	}

	public int
	GetSavedLineNum ()
	{
		return (m_nSavedLineNum);
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoProgramStart()
	{
	  // Opens the global scope.
	  m_symtab.openScope ();
      myAsWriter = new AssemblyCodeGenerator("rc.s");
	  myAsWriter.increaseIndent();
	  myAsWriter.writeStringFormat();
        }


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoProgramEnd()
	{
	  m_symtab.closeScope ();
          myAsWriter.decreaseIndent();
          myAsWriter.dispose();
	}
	
	void
	DoAutoDeclaration(String id, STO sto, String isStatic){
		if(sto.isError()){
			return;
		}
		//Check redeclare error
		if (m_symtab.accessLocal (id) != null)
		{
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.redeclared_id, id));
		}
		
		//Create a VarSTO
		VarSTO v = new VarSTO (id);
		//get the type from the sto
		v.setType(sto.getType().clone());
		//Regular declare, l-value
		v.setIsAddressable(true);
		v.setIsModifiable(true);
		
		v.setInit(sto);
		if(m_symtab.getLevel() == 1){
			String label = v.getName();	
			v.setOffset(label);
			v.setBase("%g0");
			if(isStatic!= null){
				label = ".AutoGlobalStatic_" + v.getName() + globalCounter;
				this.globalCounter++;
				v.setOffset(label);
				v.setStatic(true);
			    myAsWriter.writeStatic(v, label);
			}
			else
				myAsWriter.writeGlobal(v); 
		}
		//Local variable
		else{
		  if(isStatic!= null){
				 String label = ".AutoInternalStatic_" + v.getName() + this.globalCounter;
				 this.globalCounter++;
				 v.setStatic(true);
				 v.setBase("%g0");
				 v.setOffset(label);
				 myAsWriter.writeStatic(v, label);
	
				 myAsWriter.writeText();
				 myAsWriter.flush(myAsWriter.writeAlignment(4));
		  }
		  else{
			  m_symtab.addBytes(v.getType().getSize());
			  //Local variables negative offsets
			  v.setOffset("-" + m_symtab.getBytes());
			  v.setBase("%fp");
			  myAsWriter.writeLocal(m_symtab.getFunc().getName(), this.globalCounter, v);
			  globalCounter++;
		  }
		}
		m_symtab.insert(v);
	}
	
	void
	DoConstAutoDeclaration(String id, STO sto){
		if(sto.isError()){
			return;
		}
		
        //throw error if redeclaration occurs
		if (m_symtab.accessLocal (id) != null)
		{
			m_nNumErrors++;
			m_errors.print (Formatter.toString (ErrorMsg.redeclared_id, id));
			return;
		}
		
		if(!(sto.isConst())){
			m_nNumErrors++;
			m_errors.print (Formatter.toString (ErrorMsg.error8b_CompileTime, id));
			return;
		}
		
		//Create a VarSTO
		ConstSTO v = new ConstSTO (id);
		//get the type from the sto
		v.setType(sto.getType().clone());
		v.setValue(((ConstSTO)sto).getValue());
		//Regular declare, l-value
		v.setIsAddressable(true);
		v.setIsModifiable(false);
		
		m_symtab.insert(v);	
	}
	
	
	void
	DoNewStmtCheck(STO sto){
		if(sto.isError()){
			return;
		}
		//error should be generated if 
	    //type of sto is not a modifiable l-val
		if(!(sto.isModLValue())){
			m_nNumErrors++;
			m_errors.print (ErrorMsg.error16_New_var);
			return;
		}
		if(sto.getType().isNullPointer() || sto.getType().isFuncPointer()){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error16_New,sto.getType().getName()));
			return;
		}
		//type of sto is not a valid pointer type
		if(!(sto.getType().isGeneralPointer())){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error16_New,sto.getType().getName()));
		}
		myAsWriter.writeNewStmt(sto);
	}
	
	void
	DoDeleteStmtCheck(STO sto){
		if(sto.isError()){
			return;
		}
		//error should be generated if 
	    //type of sto is not a modifiable l-val
		if(!(sto.isModLValue())){
			m_nNumErrors++;
			m_errors.print (ErrorMsg.error16_Delete_var);
			return;
		}
		if(sto.getType().isNullPointer() || sto.getType().isFuncPointer()){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error16_Delete,sto.getType().getName()));
			return;
		}
		//type of sto is not a valid pointer type
		if(!(sto.getType().isGeneralPointer())){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error16_Delete,sto.getType().getName()));
		}
		myAsWriter.writeDeleteStmt(sto,this.globalCounter);
		globalCounter++;
	}
	
	//Check#20 pass in the string and STO 
	STO
	DoCastCheck(Type castToType, STO target){
		if(target.isError())
			return target;
		//only basic types and aliases to those types and pointers to any type
		if(target.getType().isArray() || target.getType().isStruct() || target.getType().isFuncPointer()){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error20_Cast,target.getType().getName(),castToType.getName()));
		    return new ErrorSTO(ErrorMsg.error20_Cast);
		}		
		//Check if STO is ConstSTO, if so, use casting rules
		if(target.isConst()){
			if(target.getType().isBool() && (castToType.isInt() || castToType.isFloat() || castToType.isPointer())){
			    //if is a ConstSTO of type bool
				if(((ConstSTO)target).getBoolValue()){
				   //if true
					ConstSTO tmp = new ConstSTO("type cast");
					tmp.setType(castToType.clone());
					tmp.setIsAddressable(false);
					tmp.setIsModifiable(false);
					tmp.setValue(1.0);
					return tmp;
			    }else{
			    	//if is false
			    	ConstSTO tmp = new ConstSTO("type cast");
					tmp.setType(castToType.clone());
					tmp.setValue(0.0);
					tmp.setIsAddressable(false);
					tmp.setIsModifiable(false);
					return tmp;
			    }
			}
			//else if want to cast to bool
			else if((target.getType().isInt() || target.getType().isFloat() || target.getType().isPointer()) && castToType.isBool()){
				  if(((ConstSTO)target).getValue() == 0.0){
				  	//if equals to 0
				  	ConstSTO tmp = new ConstSTO("type cast");
				  	tmp.setType(castToType.clone());
				  	tmp.setValue(0.0);
				  	tmp.setIsAddressable(false);
					tmp.setIsModifiable(false);
				  	return tmp;
				  }
				  else{
				  	//if equals to 1
				  		ConstSTO tmp = new ConstSTO("type cast");
				  		tmp.setType(castToType.clone());
				  		tmp.setValue(1.0);
				  		tmp.setIsAddressable(false);
						tmp.setIsModifiable(false);
				  		return tmp;
				   }
			     }
			//else if want to cast a float to int or pointer type
			//float --> int or pointer
			else if (target.getType().isFloat() &&(castToType.isInt() || castToType.isPointer())){
				ConstSTO tmp = new ConstSTO("type cast");
			  	tmp.setType(castToType.clone());
			  	tmp.setValue(((ConstSTO)target).getIntValue());
			  	tmp.setIsAddressable(false);
				tmp.setIsModifiable(false);
			  	return tmp;
			}
			//int or pointer --> float
			else if(castToType.isFloat() &&(target.getType().isInt() || target.getType().isPointer())){
				ConstSTO tmp = new ConstSTO("type cast");
			  	tmp.setType(castToType.clone());
			  	tmp.setValue(((ConstSTO)target).getIntValue());
			  	tmp.setIsAddressable(false);
				tmp.setIsModifiable(false);
				m_symtab.addBytes(4);
				myAsWriter.writeTypeCast(m_symtab.getBytes(), target, castToType, globalCounter);
				this.globalCounter++;
				tmp.setBase("%fp");
				tmp.setOffset("-" + m_symtab.getBytes());
			  	return tmp;	
			}
			// int <----> pointer
			else{
				ConstSTO tmp = new ConstSTO("type cast");
			  	tmp.setType(castToType.clone());
			  	//No change in value
			  	tmp.setValue(((ConstSTO)target).getValue());
			  	tmp.setIsAddressable(false);
				tmp.setIsModifiable(false);
				m_symtab.addBytes(4);
				myAsWriter.writeTypeCast(m_symtab.getBytes(), target, castToType, globalCounter);
				globalCounter++;
				tmp.setBase("%fp");
				tmp.setOffset("-" + m_symtab.getBytes());
			  	return tmp;	
			}
		}
		//If not, return ExprSTO with type t
		else{
			ExprSTO sto = new ExprSTO("type cast", castToType.clone());
			sto.setIsAddressable(false);
			sto.setIsModifiable(false);
			m_symtab.addBytes(4);
			myAsWriter.writeTypeCast(m_symtab.getBytes(), target, castToType, globalCounter);
			globalCounter++;
			sto.setBase("%fp");
			sto.setOffset("-" + m_symtab.getBytes());
			return sto;
		}
	}
	
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoVarDecl (Vector<VarSTO> stoList, Type type)
	{
		if(type.isError())
			return;
		Vector<String> lstIDs = new Vector<String>();
		for (STO s : stoList){
			lstIDs.addElement(s.getName());
		}
		for (int i = 0; i < lstIDs.size (); i++)
		{
			String id = lstIDs.elementAt (i);
			Type tmp = type.clone();
			if(stoList.elementAt(i).getType() == null){
				tmp = type.clone();
			}
			else if(stoList.elementAt(i).getType().isArray()){
				tmp = new ArrayType(type.getName()+"[" + 
							((ArrayType)(stoList.elementAt(i).getType())).getArraySize() + "]", 0);
				((ArrayType)stoList.elementAt(i).getType()).setElementType(type.clone());
			}
			else if(stoList.elementAt(i).getType().isPointer()){
				((PointerType)stoList.elementAt(i).getType()).setElementType(type.clone());
				tmp = ((PointerType)stoList.elementAt(i).getType()).clone();

				tmp.setName(((PointerType)stoList.elementAt(i).getType()).getPrintedName() + "*");
			}else if(stoList.elementAt(i).getType().isError()){
				return;
			}
			
			//Check redeclare error
			if (m_symtab.accessLocal (id) != null)
			{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.redeclared_id, id));
			}
			
			//Check global or static initialized is known at compile time
			if(stoList.elementAt(i).isStatic()){
				//If there's init
				if(stoList.elementAt(i).getInit() != null){
					//Special case where it's a funcptr
					if(type.isFuncPointer()){
						if(stoList.elementAt(i).getInit().isFunc()){
							
						}else if(stoList.elementAt(i).getInit().getType().isFuncPointer()){
							m_nNumErrors++;
							m_errors.print (Formatter.toString(ErrorMsg.error8a_CompileTime, id));
							return;
						}
					}
					else if(!(stoList.elementAt(i).getInit().isConst())){
						m_nNumErrors++;
						m_errors.print (Formatter.toString(ErrorMsg.error8a_CompileTime, id));
						return;
					}
				}
			}
			//Global or local
			else{
				//If it's  global scope
				if(m_symtab.getLevel() == 1){
					
					if(stoList.elementAt(i).getInit() != null)
					{
						//Special case where it's a funcptr
						if(type.isFuncPointer()){
							
							if(stoList.elementAt(i).getInit().isFunc()){
								
							}else if(stoList.elementAt(i).getInit().getType().isFuncPointer()){
								m_nNumErrors++;
								m_errors.print (Formatter.toString(ErrorMsg.error8a_CompileTime, id));
								return;
							}
						}
						else if(!(stoList.elementAt(i).getInit().isConst())){
							m_nNumErrors++;
							m_errors.print (Formatter.toString(ErrorMsg.error8a_CompileTime, id));
							return;
						}
					}
				}
			}


			//Check if the init type is assignable to Type
			if(stoList.elementAt(i).getInit() != null){
				//Check if STO is not modifiable value
				if (stoList.elementAt(i).getType() != null && stoList.elementAt(i).getType().isArray())
				{
					//Enter here if it's an error
					STO result = new ErrorSTO(ErrorMsg.error3a_Assign);
					result.setType(new ErrorType("error",8));
					m_nNumErrors++;
					m_errors.print (result.getName());
					return;
				}
				//If the init expression is not assignable to type declared
				if(!(stoList.elementAt(i).getInit().getType().isAssignableTo(tmp))){					
					m_nNumErrors++;
					m_errors.print (Formatter.toString(ErrorMsg.error8_Assign,stoList.elementAt(i).getInit().getType().getName(), tmp.getName()));
				    return;
				}
			}

			VarSTO 		sto = new VarSTO (id);
			sto.setStatic(stoList.elementAt(i).isStatic());
			//Check if it's an array type
			if(stoList.elementAt(i).getType() != null){
				if(stoList.elementAt(i).getType().isArray()){
					((CompositeType)stoList.elementAt(i).getType()).setElementType(type);
					//Set name to be the element type with array size
					((CompositeType)stoList.elementAt(i).getType()).setName(type.getName()+"[" + 
							((ArrayType)(stoList.elementAt(i).getType())).getArraySize() + "]");
					int size = 0;
					for(int j = 0; j < ((ArrayType)(stoList.elementAt(i).getType())).getArraySize(); j++){
						size += type.getSize();
					}
					((ArrayType)stoList.elementAt(i).getType()).setSize(size);
					sto.setType(stoList.elementAt(i).getType());
					//Array is addressable but not modifiable
					sto.setIsAddressable(true);
					sto.setIsModifiable(false);
				}
				else if(stoList.elementAt(i).getType().isFuncPointer()){
					
				}
				else if(stoList.elementAt(i).getType().isPointer()){
				
					//((PointerType)stoList.elementAt(i).getType()).setElementType(type);
					//Get name of the pointer
					((PointerType)stoList.elementAt(i).getType()).setName(
							((PointerType)stoList.elementAt(i).getType()).getPrintedName() + "*");
					sto.setType(stoList.elementAt(i).getType());
		            
					//Array is addressable but not modifiable
					sto.setIsAddressable(true);
					sto.setIsModifiable(true);
				}
			}
			else{
				//Typedef is array
				if(type.isArray()){
					sto.setType(type);
					sto.setIsAddressable(true);
					sto.setIsModifiable(false);
				}
				else{
					sto.setType(type);
					//Regular declare, l-value
					sto.setIsAddressable(true);
					sto.setIsModifiable(true);
				}
			}
			sto.setInit(stoList.elementAt(i).getInit());
			m_symtab.insert(sto);

			if(m_symtab.getLevel() == 1){
			  String label = sto.getName();
			  sto.setOffset(label);	  
			  sto.setBase("%g0");
			  if(sto.isStatic()){
				label = ".globalStatic" + sto.getName() + globalCounter;
				sto.setOffset(label);
				globalCounter++;
			    myAsWriter.writeStatic(sto, label);
			  }
			  else
		  	    myAsWriter.writeGlobal(sto); 
			}
			//Local variable
			else{
			  if(sto.isStatic()){
				 String label = ".internalStatic_" + sto.getName() + this.globalCounter;
				 this.globalCounter++;
				 sto.setBase("%g0");
				 sto.setOffset(label);
				 myAsWriter.writeStatic(sto, label);
				 this.globalCounter++;

				 myAsWriter.writeText();
				 myAsWriter.flush(myAsWriter.writeAlignment(4));
			  }else{
				  m_symtab.addBytes(sto.getType().getSize());
				  //Local variables negative offsets
				  sto.setOffset("-" + m_symtab.getBytes());
				  sto.setBase("%fp");
				  myAsWriter.writeLocal(m_symtab.getFunc().getName(), this.globalCounter, sto);
				  globalCounter++;
			  }
			}
		}
		
		//Global scope
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoExternDecl (Vector<VarSTO> lst, Type t)
	{
		Vector<String> lstIDs = new Vector<String>();
		for(STO s : lst){
			lstIDs.addElement(s.getName());
		}
		for (int i = 0; i < lstIDs.size (); i++)
		{
			String id = lstIDs.elementAt (i);

			if (m_symtab.accessLocal (id) != null)
			{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.redeclared_id, id));
			}

			VarSTO 		sto = new VarSTO (id);
			sto.setType(t);
			sto.setBase("%g0");
			sto.setIsAddressable(true);
			sto.setIsModifiable(true);
			sto.setOffset(id);
			m_symtab.insert (sto);
		}
	}

    STO
    doMinusUnary(STO s){
      myAsWriter.writeNegative(m_symtab.getBytes() + 4, s);
      ExprSTO expr = new ExprSTO(s.getName(), s.getType());
      m_symtab.addBytes(4);
      expr.setBase("%fp");
      expr.setOffset("-" + m_symtab.getBytes()); 
      return expr;
    }
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoConstDecl (Vector<VarSTO> STOlst, Type type)
	{
		if(type.isError())
			return;
		Vector<String> lstIDs = new Vector<String>();
		for(VarSTO s : STOlst){
			lstIDs.addElement(s.getName());
		}
		for (int i = 0; i < lstIDs.size (); i++)
		{
			String id = lstIDs.elementAt (i);
            //throw error if redeclaration occurs
			if (m_symtab.accessLocal (id) != null)
			{
				m_nNumErrors++;
				m_errors.print (Formatter.toString (ErrorMsg.redeclared_id, id));
				return;
			}
			//check if the const init is known at compile time
			if(!(STOlst.elementAt(i).getInit().isConst())){
				m_nNumErrors++;
				m_errors.print (Formatter.toString (ErrorMsg.error8b_CompileTime, id));
				return;
			}
			//Check if the ConstExpr is assignable to Type
			if(!(STOlst.elementAt(i).getInit().getType().isAssignableTo(type))){
				m_nNumErrors++;
				m_errors.print (Formatter.toString (ErrorMsg.error8_Assign, STOlst.elementAt(i).getInit().getType().getName(), type.getName()));
			    return;
			}
			ConstSTO 	sto = new ConstSTO (id);
			sto.setType(type);
			sto.setIsAddressable(true);
			sto.setIsModifiable(false);
			ConstSTO c = (ConstSTO)(STOlst.elementAt(i).getInit());
			sto.setValue(c.getValue());
			m_symtab.insert (sto);

			//Global const
			if(m_symtab.getLevel() == 1)
			{
			  //Global variable, offset is its name label
			  String label = sto.getName();
		      sto.setOffset(label);
			  sto.setBase("%g0");	
			 
			  if(STOlst.elementAt(i).isStatic()){
				label = ".AutoConstGlobalScope_" + sto.getName() + this.globalCounter;
				sto.setOffset(label);
				this.globalCounter++;
			    myAsWriter.writeStatic(sto, label);
			  }
			  else{
			    myAsWriter.writeGlobal(sto);
			  }
			}
			//Local const
			else {
			 if(STOlst.elementAt(i).isStatic()){
				String label = ".AutoConstInternalStatic_" + sto.getName() + this.globalCounter;
				this.globalCounter++;
				myAsWriter.writeStatic(sto, label);
				this.globalCounter++;
				sto.setBase("%g0");
				sto.setOffset(label);
				myAsWriter.writeText();
				myAsWriter.flush(myAsWriter.writeAlignment(4));
			  }else{
				  m_symtab.addBytes(sto.getType().getSize());
		      	//Local variables negative offsets
		      	sto.setOffset("-" + m_symtab.getBytes());
		      	sto.setBase("%fp");	 
		      	myAsWriter.writeConstLocal(m_symtab.getFunc().getName(), this.globalCounter, sto);
			  	globalCounter++;
			  }
			}
		}
	}
	

    //----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoTypedefDecl (Type type, Vector<String> lstIDs)
	{
		if(type.isError())
			return;
		for (int i = 0; i < lstIDs.size (); i++)
		{
			String id = lstIDs.elementAt (i);

			if (m_symtab.accessLocal (id) != null)
			{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.redeclared_id, id));
			}
			//set the name of the TypedefSTO
			TypedefSTO 	sto = new TypedefSTO (id);
			
			sto.setType(type.clone());

			m_symtab.insert (sto);
		}
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoStructdefDecl (String id)
	{ 
		//Check redeclare id
		if (m_symtab.accessLocal (id) != null)
		{
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.redeclared_id, id));
		}

		TypedefSTO 	sto = new TypedefSTO (id);
		StructType st = new StructType(id, 0);
		sto.setType(st.clone());
		m_symtab.insert (sto);
		m_symtab.setStruct(sto);
		m_symtab.setStructDefineComplete(false);
	}
	
	void 
	DoStructFieldFill(){
		Vector<STO> structFields = m_symtab.getDeclaredField();
		int size = 0;
		for(STO s : structFields){
			size += s.getType().getSize();
		}
		StructType st = (StructType) m_symtab.getStruct().getType();
		st.setField(structFields);
		//Set the size of the struct
		st.setSize(st.getStructSize());
		m_symtab.access(m_symtab.getStruct().getName()).setType(st);
		
	}
	void 
	DoStructdefDeclEnd(){
		StructType tmp = (StructType)m_symtab.access(m_symtab.getStruct().getName()).getType();
		Vector<STO> structFields = tmp.getField();
		for(STO s : structFields){
			if(s.getType().isPointer() && 
			((PointerType)s.getType()).getElementType().getName().equals(m_symtab.getStruct().getName())){
				((PointerType)s.getType()).getElementType().setSize(m_symtab.getStruct().getType().getSize());
			}
		}
		m_symtab.access(m_symtab.getStruct().getName()).setType(tmp);
		m_symtab.setStruct(null);
		m_symtab.setStructDefineComplete(true);		
	}
    
	STO
	DoStructFieldDecl (Vector<VarSTO> vlist){
		boolean Error = false;
		for(VarSTO v : vlist ){
			
			String id = v.getName();
			//Check if the id is already declared in the struct
			if(m_symtab.accessLocal(id)!= null){
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error13a_Struct, id));
				Error = true;
			}
			else{
				m_symtab.insert (v);
			}
		}
		//
		if(Error){
			return new ErrorSTO("struct field error");
		}else{
			for(VarSTO v : vlist ){
			//Check if recursive struct definition
				if(v.getType().isStruct()){
					//If the field declare is equal to the name of the current struct
					if(v.getType().getName().equals(m_symtab.getStruct().getName())){
						m_nNumErrors++;
						m_errors.print (Formatter.toString(ErrorMsg.error13b_Struct,v.getName()));
						Error = true;
					}
				}
				else if(v.getType().isArray()){
					//If the field declare is equal to the name of the current struct
					if(((ArrayType)v.getType()).getElementType().getName().equals(m_symtab.getStruct().getName())){
						m_nNumErrors++;
						m_errors.print (Formatter.toString(ErrorMsg.error13b_Struct,v.getName()));
						Error = true;
					}
				}
			}
			if(Error){
				return new ErrorSTO("struct field error");
			}
			else
				return null;
		}
	}
	
	/*
	 * this function is for dereference an object
	 */
	STO
	doDereferenceCheck(STO deref){
		if(deref.isError()){
			return deref;
		}
		if((deref.getType().isNullPointer())){
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.error15_Receiver, deref.getType().getName()));
			return new ErrorSTO("pointer dereference error");
		}
		if(!(deref.getType().isPointer())){
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.error15_Receiver, deref.getType().getName()));
			return new ErrorSTO("pointer dereference error");
		}
		//The dereference operator is used on pointer
		else{
			//Return an sto of the element type
			Type t = ((PointerType)deref.getType()).getElementType().clone();
			if(t.isStruct()){
				STO s = m_symtab.access(t.getName());
				t.setSize(s.getType().getSize());
			}
			ExprSTO sto = new ExprSTO("pointer_dereference", t);
			sto.setIsAddressable(true);
			sto.setIsModifiable(true);
			sto.setBase("%fp");
			m_symtab.addBytes(4);
			sto.setOffset("-" + m_symtab.getBytes());
			sto.setHoldAddress(true);
			myAsWriter.writeDereferenceOp(deref, m_symtab.getBytes(),this.globalCounter);
			globalCounter++;
			return sto;
		}
	}
	
	STO
	DoArrowOp(STO ptr, String fieldName){
		if(ptr.isError()){
			return ptr;
		}
		//Check if the arrow's left is a pointer to a struct
		if(!(ptr.getType().isPointer()) || (ptr.getType().isNullPointer())){
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.error15_ReceiverArrow, ptr.getType().getName()));
			return new ErrorSTO("struct pointer arrow error");
		}
		
		//left side is good, check there's field x and get the exprSTO with the type x
		else{
			if(!((PointerType)ptr.getType()).getElementType().isStruct()){
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error15_ReceiverArrow, ptr.getType().getName()));
				return new ErrorSTO("struct pointer arrow error");
			}else{
				m_symtab.addBytes(4);
				myAsWriter.writeDereferenceOp(ptr, m_symtab.getBytes(),this.globalCounter);
				globalCounter++;
				ExprSTO sto = new ExprSTO("tmp", ((PointerType)ptr.getType()).getElementType());
				sto.setBase("%fp");
				sto.setOffset("-" + m_symtab.getBytes());
				sto.setHoldAddress(true);
				STO s = (DoDesignator2_Dot(sto, fieldName));
				Type t;
				if(s.isError())
					return s;
				t = s.getType();
				ExprSTO ret = new ExprSTO("pointer to struct arrow", t);
				ret.setIsAddressable(true);
				ret.setIsModifiable(true);
				ret.setBase(s.getBase());
				ret.setOffset(s.getOffset());
				ret.setHoldAddress(true);
				return ret;
			}
		}
	}
	
	STO
	doAddressOfCheck(STO target){
		if(target.isError())
			return target;
		if(!(target.getIsAddressable())){
			m_nNumErrors++;
			ErrorSTO ret = new ErrorSTO(Formatter.toString(ErrorMsg.error21_AddressOf, target.getType().getName()));
			m_errors.print(ret.getName());
			return ret;
		}
		Type newType = new PointerType(target.getType().getName()+"*", 4);
		((PointerType)newType).setElementType(target.getType());
		ExprSTO ret = new ExprSTO("AddressOfOp", newType);
		ret.setType(newType.clone());
		//Addressof results in a R-value
		ret.setIsAddressable(false);
		ret.setIsModifiable(false);
		m_symtab.addBytes(4);
		myAsWriter.writeAddressOfOp(target, m_symtab.getBytes());
		ret.setBase("%fp");
		ret.setOffset("-" + m_symtab.getBytes());
		return ret;
	}
	
	void
	DoExternFuncDecl_1 (Type returnType, String id)
	{
		if(returnType.isError())
			return;
		//Check if the function is already in the symbol table
		if (m_symtab.accessLocal (id) != null)
		{
			//Check if it's a valid overload
			STO tmp = m_symtab.accessLocal(id);
			
			//Check if the id is a valid function
			if(tmp.isFunc()){
				//Mark as an overloaded func
				FuncSTO overloaded =  new FuncSTO(id);
				FunctionPointerType type = new FunctionPointerType("funcptr", 4);
				type.setReturnType(returnType);
				overloaded.setType(type);
				((FuncSTO)tmp).setOverloaded(true);
				overloaded.setOverloaded(true);
				//((FuncSTO)tmp).addOverloadFunc(overloaded);	
				m_symtab.openScope ();
				m_symtab.setFunc (overloaded);
				m_symtab.getFunc().setReturnType(returnType);
				return;
			}
			else{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.redeclared_id, id));
			}
		}
	
		FuncSTO sto = new FuncSTO (id);//initialize here so that we can insert parameter into the FuncSTO
		sto.setBase("%g0");
		sto.setOffset(id);
		//FunctSTO are always FunctionPointerType
		FunctionPointerType type = new FunctionPointerType("funcptr", 4);
	   
		//Set its return type
		type.setReturnType(returnType);
		sto.setType(type);
		m_symtab.insert (sto);//inserted into current scope
		m_symtab.openScope ();
		m_symtab.setFunc (sto);
		m_symtab.getFunc().setReturnType(returnType);
	}
	
	void
	DoExternFuncDecl_2 ()
	{
	  if(m_symtab.getFunc().getDefineError()){
	    m_symtab.closeScope ();//close scope(pops top scope off)
	    m_symtab.setFunc (null);//Say we are back in outer scope
	    return;
	  }
	  m_symtab.getFunc().getType().setName(((FunctionPointerType)(m_symtab.getFunc().getType())).getErrorName());
	  m_symtab.closeScope ();//close scope(pops top scope off)
	  m_symtab.setFunc (null);//Say we are back in outer scope
	}

	void
	DoExternFormalParams (Vector<STO> params)
	{
		
		if (m_symtab.getFunc () == null)
		{
			m_nNumErrors++;
			m_errors.print ("internal: DoFormalParams says no proc!");
		}
		if(m_symtab.getFunc().isOverloaded()){
			overloadCheck(params,m_symtab.getFunc().getName());
			return;
		}
		//If no arguments, return
		else if(params.size() == 0)
                  return;
		else{
			//Add all the param to the symbal table and FuncSTO
			for(int i = 0; i < params.size(); i++){
				if(params.elementAt(i).getType().isArray())
					params.elementAt(i).getType().setReference(true);
				STO s = params.elementAt(i);		
				//Check #19, all formal param are variables, which are mod l-val
				s.setIsAddressable(true);
				s.setIsModifiable(true);
				((FunctionPointerType)(m_symtab.getFunc().getType())).addParameter(s);
				m_symtab.getFunc().addParameter(s);
				m_symtab.insert(s);
			}
		}
		m_symtab.getFunc().getType().setName(((FunctionPointerType)(m_symtab.getFunc().getType())).getErrorName());
	}
	
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoFuncDecl_1 (Type returnType, String id)
	{
		if(returnType.isError())
			return;
		//Check if the function is already in the symbol table
		if (m_symtab.accessLocal (id) != null)
		{
			//Check if it's a valid overload
			STO tmp = m_symtab.accessLocal(id);
			
			//Check if the id is a valid function
			if(tmp.isFunc()){
				//Mark as an overloaded func
				FuncSTO overloaded =  new FuncSTO(id);
				FunctionPointerType type = new FunctionPointerType("funcptr", 4);
				type.setReturnType(returnType);
				overloaded.setType(type);
				((FuncSTO)tmp).setOverloaded(true);
				//Set name mangling for the base function to be the same as its name
				((FuncSTO)tmp).setNameMangling();
				//Set name mangling for this overloaded function
				overloaded.setNameMangling(this.globalCounter);
				this.globalCounter++;
				overloaded.setOverloaded(true);

				m_symtab.openScope ();
				m_symtab.setFunc (overloaded);
				m_symtab.getFunc().setReturnType(returnType);
				//Write out assembly code
				myAsWriter.writeFunc(overloaded, this.globalCounter);
				globalCounter++;
				return;
			}
			else{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.redeclared_id, id));
			}
			//FuncSTO overloaded = (FuncSTO) m_symtab.accessLocal(id);
		}
	
		FuncSTO sto = new FuncSTO (id);//initialize here so that we can insert parameter into the FuncSTO
		sto.setBase("%g0");
		sto.setOffset(id);
		//FunctSTO are always FunctionPointerType
		FunctionPointerType type = new FunctionPointerType("funcptr", 4);
	   
		//Set its return type
		type.setReturnType(returnType);
		sto.setType(type);
		m_symtab.insert (sto);//inserted into current scope
		m_symtab.openScope ();
		m_symtab.setFunc (sto);
		m_symtab.getFunc().setReturnType(returnType);
		//Write out assembly code
		myAsWriter.writeFunc(sto, this.globalCounter);
		globalCounter++;
	}
	
	

	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoFuncDecl_2 ()
	{
	  if(m_symtab.getFunc().getDefineError()){
	    m_symtab.closeScope ();//close scope(pops top scope off)
	    m_symtab.setFunc (null);//Say we are back in outer scope
	    return;
	  }
	  m_symtab.getFunc().getType().setName(((FunctionPointerType)(m_symtab.getFunc().getType())).getErrorName());
	  m_symtab.closeScope ();//close scope(pops top scope off)
	  //No top level return statement has been seen
	  if (m_symtab.getFunc().getTopLevelReturn() == false && !(m_symtab.getFunc().getReturnType().isVoid())){
	    m_nNumErrors++;
	    m_errors.print (ErrorMsg.error6c_Return_missing);
	  }
	  myAsWriter.writeRetRestore();
	  myAsWriter.writeSaveSpace(m_symtab.getFunc(), m_symtab.getBytes());
	  m_symtab.clearBytes();
	  //myAsWriter.writeStrings(m_symtab.getFunc().getName(), this.coutStrings);
	  //Clear the strings
	  //this.coutStrings.removeAllElements();
	  m_symtab.setFunc (null);//Say we are back in outer scope
	}

	private void overloadCheck(Vector<STO> params, String functionName){
		FuncSTO needToBeCheckedFunc = m_symtab.getFunc();
		
		FuncSTO original = (FuncSTO)m_symtab.access(functionName);
		Vector<FuncSTO> checkTarget = (Vector<FuncSTO>) original.getOverloadFuncList().clone();
		checkTarget.addElement(original);
		boolean valid = true;
		Vector<FuncSTO> potential = new Vector<FuncSTO>();
		for(int i = 0; i < checkTarget.size();i++){
			FuncSTO tmp = checkTarget.get(i);
			if(tmp.getParameterNumbers() != params.size()){
				continue;
			}
			else{
				//Add to the potential 
				potential.addElement(tmp);
			}
		}
		//after the for loop we get the FuncSTO that has the same number of parameter
		if(potential.size() == 0){	

			int offset = 68;
			//Add all the param to the symbal table and FuncSTO
			for(int i = 0; i < params.size(); i++){
				STO s = params.elementAt(i);
				//Check #19, all formal param are variables, which are mod l-val
				s.setIsAddressable(true);
				s.setIsModifiable(true);
				s.setBase("%fp");
				s.setOffset("" + offset);
				((FunctionPointerType)(m_symtab.getFunc().getType())).addParameter(s);
				//if(params.get(i).getType().isArray())
					//s.getType().setReference(true);
				m_symtab.getFunc().addParameter(s);
				m_symtab.insert(s);
				//If it's greater than the first sixth argument, it's been put on the stack
				if(i > 5){
				}	
				else{
					myAsWriter.writeFormalParam(s, i);
				}
				if(s.getType().isStruct()){
					offset = offset + 4;
				}
				else
					offset = offset + s.getType().getSize();
			}
			
			//we know the function is successfully overloaded and we can add to list
			original.addOverloadFunc(needToBeCheckedFunc);
			return;
		}
		// there are same number of parameters, need to check equivalence
		for(int i = 0; i< potential.size();i++){
			FuncSTO tmp = potential.get(i);
			Vector<STO> tmpList = tmp.getParameterSTO();
			int count = 0;
			for(int j = 0; j< tmpList.size();j++){
				if(tmpList.get(j).getType().isEquivalentTo(params.get(j).getType())){
					count++;
				}
			}
			//Check if count equals to the size of the paramter list
			if(count == tmpList.size()){
				if(original.getOverloadFuncList().size() == 0){
					original.setOverloaded(false);
					needToBeCheckedFunc.setDefineError(true);
				}
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error22_Decl, needToBeCheckedFunc.getName()));
				for(STO s : params)
				{
					//Check #19, all formal param are variables, which are mod l-val
					s.setIsAddressable(true);
					s.setIsModifiable(true);
					((FunctionPointerType)(m_symtab.getFunc().getType())).addParameter(s);
					m_symtab.getFunc().addParameter(s);
					m_symtab.insert(s);
				}
				return;
			}
		}
	
		int offset = 68;
		//Add all the param to the symbal table and FuncSTO
		for(int i = 0; i < params.size(); i++){
			STO s = params.elementAt(i);
			//Check #19, all formal param are variables, which are mod l-val
			s.setIsAddressable(true);
			s.setIsModifiable(true);
			s.setBase("%fp");
			s.setOffset("" + offset);
			((FunctionPointerType)(m_symtab.getFunc().getType())).addParameter(s);
			//if(params.get(i).getType().isArray())
				//s.getType().setReference(true);
			m_symtab.getFunc().addParameter(s);
			m_symtab.insert(s);
			//If it's greater than the first sixth argument, it's been put on the stack
			if(i > 5){
			}	
			else{
				myAsWriter.writeFormalParam(s, i);
			}
			offset = offset + s.getType().getSize();
		}
		
		//Enter here if it's valid
		original.addOverloadFunc(needToBeCheckedFunc);
	}

	//----------------------------------------------------------------
	// DoFormalParams need to store all parameters to the FuncSTO and 
	// add all parameter list name binded to type and store in the 
	// symbol table
	//----------------------------------------------------------------
	void
	DoFormalParams (Vector<STO> params)
	{
		
		if (m_symtab.getFunc () == null)
		{
			m_nNumErrors++;
			m_errors.print ("internal: DoFormalParams says no proc!");
		}
		if(m_symtab.getFunc().isOverloaded()){
			overloadCheck(params,m_symtab.getFunc().getName());
			return;
		}
		//If no arguments, return
		else if(params.size() == 0)
                  return;
		else{
			int offset = 68;
			//Add all the param to the symbal table and FuncSTO
			for(int i = 0; i < params.size(); i++){
				STO s = params.elementAt(i);
				//Check #19, all formal param are variables, which are mod l-val
				s.setIsAddressable(true);
				s.setIsModifiable(true);
				s.setBase("%fp");
				s.setOffset("" + offset);
				((FunctionPointerType)(m_symtab.getFunc().getType())).addParameter(s);
				m_symtab.getFunc().addParameter(s);
				m_symtab.insert(s);
				//If it's greater than the first sixth argument, it's been put on the stack
				if(i > 5){
				}	
				else{
					myAsWriter.writeFormalParam(s, i);
				}
				if(s.getType().isStruct()){
					offset = offset + 4;
				}
				else
					offset = offset + s.getType().getSize();
			}
		}
		m_symtab.getFunc().getType().setName(((FunctionPointerType)(m_symtab.getFunc().getType())).getErrorName());
	}
	
	void
	DoReturnCheck(STO s){
		
		if (m_symtab.getFunc () == null)
		{
			m_nNumErrors++;
			m_errors.print ("internal: DoReturnCheck says no proc!");
			return;
		}
		//It's top level and a return statement is found
		if(m_symtab.getLevel() == 2){
			m_symtab.getFunc().setTopLevelReturn(true);
		}
		if(s.isError()){
			return;
		}
		Type t = s.getType();
		//Check if the return type is by reference or value
		if(m_symtab.getFunc().getReturnType().isReference()){
		  //Check if the type of return expression is not equivalent to the return 
		  //type of the function
			if(!m_symtab.getFunc().getReturnType().isVoid() && t.isVoid()){
				m_nNumErrors++;
				m_errors.print (ErrorMsg.error6a_Return_expr);
				return;
			}
		  if(!(t.isEquivalentTo(m_symtab.getFunc().getReturnType()))){
			  m_nNumErrors++;
			  m_errors.print (Formatter.toString(ErrorMsg.error6b_Return_equiv, t.getName(),m_symtab.getFunc().getReturnType().getName()));
			  return;
		  }
		  //return expression is not a modifiable L-value
		  if(!(s.isModLValue())){
			  m_nNumErrors++;
			  m_errors.print (ErrorMsg.error6b_Return_modlval);
			  return;
		  }
		}
		else{
			//no expr is specified and the return type is not void
			if(!(m_symtab.getFunc().getReturnType().isVoid())){
				//Return should not be void but is void
				if(t.isVoid()){
					m_nNumErrors++;
					m_errors.print (ErrorMsg.error6a_Return_expr);
					return;
				}
				//user given return type is not assignable to function return type
				if(!(t.isAssignableTo(m_symtab.getFunc().getReturnType()))){
					m_nNumErrors++;
					m_errors.print (Formatter.toString(ErrorMsg.error6a_Return_type, t.getName(),m_symtab.getFunc().getReturnType().getName()));
				    return;
				}
			}
			else{
				//user given return type is not assignable to function return type
				if(!(t.isAssignableTo(m_symtab.getFunc().getReturnType()))){
					m_nNumErrors++;
					m_errors.print (Formatter.toString(ErrorMsg.error6a_Return_type, t.getName(),m_symtab.getFunc().getReturnType().getName()));
				    return;
				}
			}
		}
		myAsWriter.writeReturnStmt(m_symtab.getFunc().getName(), s, this.globalCounter, m_symtab.getFunc().getReturnType());
		myAsWriter.writeRetRestore();
		this.globalCounter++;
		return;
	}

	void
	DoCoutStmt(STO s){
	  if(s.isConst()){
		  String str = s.getName();
		  if(str.equals("\n")){
		    myAsWriter.writeEndl();
		  }
		  else if(s.getType() != null && s.getType().isInt()){
			myAsWriter.writeConstIntTol0(((ConstSTO)s).getIntValue());
			myAsWriter.writeCoutInt();
		  }
		  else if(s.getType() != null && s.getType().isFloat()){
			myAsWriter.writeConstFloatTol0(((ConstSTO)s).getFloatValue(), this.globalCounter);
			globalCounter++;
			myAsWriter.writeCoutFloat();
		  }
		  else if(s.getType() != null && s.getType().isBool()){		
			String value = "" + ((ConstSTO)s).getBoolValue();
			this.coutStrings.addElement(new ConstSTO(value));
			myAsWriter.writeCout(m_symtab.getFunc().getName(), coutStrings.size(), value);	 
		  }
		  else{
		    this.coutStrings.addElement(new ConstSTO(str));
		    myAsWriter.writeCout(m_symtab.getFunc().getName(), coutStrings.size(),str);	    
		  }
	  }
	  //Generate code for variable
	  else if (s.isVar()){
		//These assumes do des put the correct value into %l0
		if(s.getType().isInt()){
		  myAsWriter.writeCoutInt();
		}
		else if(s.getType().isBool()){
		  myAsWriter.writeCoutBool(this.globalCounter);
		  globalCounter++;
		}
		else if(s.getType().isFloat()){
		  myAsWriter.writeCoutFloat();
		}
	  }
	  //If the cout is an expression
	  else if(s.isExpr()){

		myAsWriter.writeDoDesID(s);
		//These assumes do des put the correct value into %l0
		if(s.getType().isInt()){
		  myAsWriter.writeCoutInt();
		}
		else if(s.getType().isBool()){
		  myAsWriter.writeCoutBool(this.globalCounter);
		  globalCounter++;
		}
		else if(s.getType().isFloat()){
		  myAsWriter.writeCoutFloat();
		}
	  }
	}
	
	void
	DoCinStmt(STO s){
		if(s.getType().isInt()){
			myAsWriter.writeCinInt(s);
		}
		else if(s.getType().isFloat()){
			myAsWriter.writeCinFloat(s);
		}
	}
	
	void
	DoExitStmtCheck(STO s){
		if(s.isError())
			return;
		//check if the STO is assignable to an int
		if(!(s.getType().isAssignableTo(new IntType("int",4)))){
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.error7_Exit, s.getType().getName()));
		}
		myAsWriter.writeExit(s, globalCounter);
		globalCounter++;
		
	}
	
	void
	DoBreakStmtCheck(){
		//program + function + while loop
		if(!(m_symtab.isInWhileLoop())){
			m_nNumErrors++;
			m_errors.print (ErrorMsg.error12_Break);
		}
		myAsWriter.writeBreakStmt(this.WhileStmtEndLabels.peek());
	}
	
	void
	DoContinueStmtCheck(){
		//program + function + while loop
		if(!(m_symtab.isInWhileLoop())){
		  m_nNumErrors++;
		  m_errors.print (ErrorMsg.error12_Continue);
		}	
		myAsWriter.writeContinueStmt(this.WhileStmtLabels.peek());
	}

    //----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoBlockOpen ()
	{
		if(this.m_symtab.isInWhileLoop())
		  this.m_symtab.incrementWhileLevel();
		// Open a scope.
		m_symtab.openScope ();
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	void
	DoBlockClose()
	{
		//If the block closing is in the while loop, decrement the level
		if(this.m_symtab.isInWhileLoop()){
			this.m_symtab.decrementWhileLevel();
			//If the level reach 0, then no more while loop
			if(this.m_symtab.getWhileLevel() == 0)
				this.m_symtab.inWhileLoop(false);
		}
		m_symtab.closeScope ();
	}
	
	//Check #1
	STO
	DoBinaryExpr(STO a, BinaryOp o, STO b)
	{
		if(a.isError())
			return a;
		else if(b.isError())
			return b;
		else{
			STO result = o.checkOperands(a, b);
		    if (result.isError()) {
		    	result.setType(new ErrorType("error",8));
		    	m_nNumErrors++;
				m_errors.print (result.getName());
		    }
		    //Generate code for getting both operand
		    m_symtab.addBytes(4);
		    switch(result.getName()){
		      case "AddOp":
		    	//Check if need bytes for prompting
		    	if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
		    	    m_symtab.addBytes(4);
		    		myAsWriter.writeAddOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	}else{
		          myAsWriter.writeAddOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	}
		    	globalCounter++;
		        break;
		      case "MinusOp":
		    	  if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
			    	  m_symtab.addBytes(4);
			    	  myAsWriter.writeMinusOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	  }else{
		    		  myAsWriter.writeMinusOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	  }
		    	  globalCounter++;
		    	break;
		      case "MulOp":
		    	  if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
			    	  m_symtab.addBytes(4);
			    	  myAsWriter.writeMulOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	  }else{
		    		  myAsWriter.writeMulOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	  }
		    	  globalCounter++;
		    	break;
		      case "DivOp":
		    	  if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
			    	  m_symtab.addBytes(4);
			    	  myAsWriter.writeDivOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	  }else{
		    		  myAsWriter.writeDivOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	  }
		    	  globalCounter++;
		    	break;
		      case "ModOp":
		    	myAsWriter.writeModOp(m_symtab.getBytes(), a, b);
		    	break;
		      case "BwAndOp":
		    	myAsWriter.writeBwAndOp(m_symtab.getBytes(), a, b);
		    	break;
		      case "BwOrOp":
		    	myAsWriter.writeBwOrOp(m_symtab.getBytes(), a, b);
		    	break;
		      case "BwXorOp":
		    	myAsWriter.writeBwXorOp(m_symtab.getBytes(), a, b);
		    	break;
		      case "GreaterThanOp":
		    	myAsWriter.writeGreaterThanOp(m_symtab.getBytes(), a, b, this.globalCounter);
		    	this.globalCounter++;
		    	break;
              case "GreaterAndEqualThanOp":
                myAsWriter.writeGreaterAndEqualThanOp(m_symtab.getBytes(),a,b,this.globalCounter);
                this.globalCounter++;
                break;
              case "LessThanOp":
            	  myAsWriter.writeLessThanOp(m_symtab.getBytes(),a,b,this.globalCounter);
            	  this.globalCounter++;
            	  break;
              case "LessAndEqualThanOp":
            	  myAsWriter.writeLessAndEqualThanOp(m_symtab.getBytes(),a,b,this.globalCounter);
            	  this.globalCounter++;
            	  break;
              case "NotEqualOp":
            	  myAsWriter.writeNotEqualOp(m_symtab.getBytes(),a,b,this.globalCounter);
            	  this.globalCounter++;
            	  break;
              case "EqualOp":
            	  myAsWriter.writeEqualOp(m_symtab.getBytes(),a,b,this.globalCounter);
            	  this.globalCounter++;
            	  break;
              case "AndOp":
            	  String Andlabel = "";
            	  
            	  Andlabel = this.AndShortCircuitLabel.pop();
            	  myAsWriter.writeAndOp(m_symtab.getBytes(), a,b, this.globalCounter, Andlabel);
            	  this.globalCounter++;
            	  break;
              case "OrOp":
            	  String Orlabel = "";
            	  
            	  Orlabel = this.OrShortCircuitLabel.pop();
            	  myAsWriter.writeOrOp(m_symtab.getBytes(), a,b, this.globalCounter, Orlabel);
            	  this.globalCounter++;
            	  break;
            }
		  
		    result.setOffset("-" + m_symtab.getBytes());
		    result.setBase("%fp");
		    return result;
		}
	}
	void
	doDecltype(){
	  myAsWriter.writeDecltype(this.globalCounter);
	  this.decltypeLabels.push(globalCounter);
	  globalCounter++;
	}
	void 
	doDecltypeDone(){
	  Integer labelCount = this.decltypeLabels.pop();
	  myAsWriter.writeDecltypeDone(labelCount);
	}
	
	STO
	DoUnaryExpr(STO a, UnaryOp o)
	{
		if(a.isError())
			return a;
		STO result = o.checkOperands(a);
		if(result.isError()){
			result.setType(new ErrorType("error",8));
			m_nNumErrors++;
			m_errors.print (result.getName());
		}
		
		//Generate code for getting both operand
		m_symtab.addBytes(4);
	    switch(result.getName()){
	      case "preIncOp":
	    	  myAsWriter.writePreIncOp("-" + m_symtab.getBytes(), a);
	    	  result.setOffset("-" + m_symtab.getBytes());
	  	      result.setBase("%fp");
	    	break;
	      case "postIncOp":
	    	 
	    	  myAsWriter.writePostIncOp("-" + m_symtab.getBytes(), a);
	    	  result.setOffset("-" + m_symtab.getBytes());
	  	      result.setBase("%fp");
		    break;
	      case "preDecOp":
	    	  myAsWriter.writePreDecOp("-" + m_symtab.getBytes(), a);
	    	  result.setOffset("-" + m_symtab.getBytes());
	  	      result.setBase("%fp");
		    break;
	      case "postDecOp":
	    	  myAsWriter.writePostDecOp("-" + m_symtab.getBytes(), a);
	    	  result.setOffset("-" + m_symtab.getBytes());
	  	      result.setBase("%fp");
		    break;
	      case "NotOp":
	    	  m_symtab.addBytes(4);
	    	  myAsWriter.writeNotOp("-" + m_symtab.getBytes(), a, this.globalCounter);
	    	  globalCounter++;
	    	  result.setOffset("-" + m_symtab.getBytes());
	  	      result.setBase("%fp");
	    }
	   
		return result;
	}

	void
	DoOrOpCheckFirst(STO a){
		String label = "OrOp_True" + globalCounter;
		this.OrShortCircuitLabel.push(label);
		myAsWriter.writeOrOpFirst(m_symtab.getBytes(), a, label, globalCounter);
		this.globalCounter++;
	}
	void 
	DoAndOpCheckFirst(STO a){
		String label = "AndOp_True" + globalCounter;
		this.AndShortCircuitLabel.push(label);
		myAsWriter.writeAndOpFirst(m_symtab.getBytes(), a, label, globalCounter);
		this.globalCounter++;
	}
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	STO
	DoAssignExpr (STO leftHandSide, STO rightHandSide)
	{
		//Check #3a
		if(rightHandSide.isError())
			return rightHandSide;
		else if(leftHandSide.isError())
			return leftHandSide;
		//Check if STO is not modifiable value
		if (!leftHandSide.isModLValue())
		{
			//Enter here if it's an error
			STO result = new ErrorSTO(ErrorMsg.error3a_Assign);
			result.setType(new ErrorType("error",8));
			m_nNumErrors++;
			m_errors.print (result.getName());
			return result;
			// Good place to do the assign check		
		}
		//
		if(leftHandSide.getType().isFuncPointer() && rightHandSide.isFunc() && 
				((FuncSTO)rightHandSide).isOverloaded()){
			Vector<FuncSTO> candidates = ((FuncSTO)rightHandSide).getOverloadFuncList();
			candidates.addElement((FuncSTO) rightHandSide);
			for(int i = 0;i< candidates.size();i++){
				FuncSTO tmp = candidates.get(i);
				if(!(leftHandSide.getType().isEquivalentTo(tmp.getType()))){
					//If not equivalent type, continue checking other candidates
					continue;
				}
				else{
					//if has equivalent type
					ExprSTO result = new ExprSTO(leftHandSide.getName() + " = " + rightHandSide.getName());
					result.setType(leftHandSide.getType().clone());
					
					m_symtab.addBytes(4);
					myAsWriter.writeAssignment(leftHandSide, rightHandSide, this.globalCounter, m_symtab.getBytes());
					result.setBase("%fp");
					result.setOffset("-" + m_symtab.getBytes());
					result.setIsAddressable(false);
					result.setIsModifiable(false);
					return result;
				}
			}
			STO result = new ErrorSTO(Formatter.toString(ErrorMsg.error3b_Assign,rightHandSide.getType().getName(),
				    leftHandSide.getType().getName()));
			result.setType(new ErrorType("error",8));
			m_nNumErrors++;
			m_errors.print (result.getName());
			return result;
		}//end of if statement
		
		
		//It's a good modifiable L-value
		//Check #3b
		//Check if the expr is not assignable to the designator
		if (!rightHandSide.getType().isAssignableTo(leftHandSide.getType())){
			STO result = new ErrorSTO(Formatter.toString(ErrorMsg.error3b_Assign,rightHandSide.getType().getName(),
					    leftHandSide.getType().getName()));
			result.setType(new ErrorType("error",8));
			m_nNumErrors++;
			m_errors.print (result.getName());
			return result;
		}
		ExprSTO result = new ExprSTO(leftHandSide.getName() + " = " + rightHandSide.getName());
		Type left_type = leftHandSide.getType().clone();
		left_type.setReference(leftHandSide.getType().isReference());
		result.setType(left_type);
		result.setIsAddressable(false);
		result.setIsModifiable(false);
		if(leftHandSide.getType().isFloat() && rightHandSide.getType().isInt()){
			//Need promption
			m_symtab.addBytes(rightHandSide.getType().getSize());
			myAsWriter.writeAssignment(leftHandSide, rightHandSide, this.globalCounter, m_symtab.getBytes());
			result.setBase(leftHandSide.getBase());
			result.setOffset(leftHandSide.getOffset());
			if((leftHandSide.isExpr() &&  ((ExprSTO)leftHandSide).getHoldAddress())){
				result.setHoldAddress(true);
			}
			
		}
		else{
			m_symtab.addBytes(rightHandSide.getType().getSize());
			
			boolean previous_reference = rightHandSide.getType().isReference();
			for (STO s : m_symtab.getFunc().getParameterSTO()){
				if(s.getName().equals(rightHandSide.getName())){
					rightHandSide.getType().setReference(true);
				}
			}
			myAsWriter.writeAssignment(leftHandSide, rightHandSide, this.globalCounter, m_symtab.getBytes());

			rightHandSide.getType().setReference(previous_reference);
			
			result.setBase(leftHandSide.getBase());
			result.setOffset(leftHandSide.getOffset());
			if((leftHandSide.isExpr() &&  ((ExprSTO)leftHandSide).getHoldAddress())){
				result.setHoldAddress(true);
			}
			
		}
		globalCounter++;
		return result;
	}

	STO
	DoSizeOfDes(STO var){
		if(var.isError()){
			return var;
		}
		if(var.getType().isNullPointer()){
			
			int size = var.getType().getSize();
			ConstSTO ret = new ConstSTO(var.getName()+"'s size");
			ret.setValue(size);
			ret.setType(new IntType("int", 4));
			return ret; 
		}
		//Check if the operand is addressable
		if(!(var.getIsAddressable())){
			m_nNumErrors++;
			m_errors.print (ErrorMsg.error19_Sizeof);
			return new ErrorSTO("sizeof not addressable");
		}
		else{
			int size = var.getType().getSize();
			ConstSTO ret = new ConstSTO(var.getName()+"'s size");
			ret.setValue(size);
			
			ret.setType(new IntType("int", 4));
			return ret; 
		}
	}
	
	STO
	DoSizeOfType(Type t){
		if(t.isError()){
			return new ErrorSTO("sizeof error type");
		}
		if(t.isError()){
			m_nNumErrors++;
			m_errors.print (ErrorMsg.error19_Sizeof);
			return new ErrorSTO("sizeof not a type");
		}
		else{
			int size = t.getSize();
			ConstSTO ret = new ConstSTO(t.getName()+"'s size");
			ret.setValue(size);
			ret.setType(new IntType("int", 4));
			return ret;
		}
	}
	
	void DoWhileStmt(STO s){
		this.m_symtab.inWhileLoop(true);
		myAsWriter.writeDoDesID(s);
		myAsWriter.writeWhileCheckCondition(this.WhileStmtEndLabels.peek());
	}
	void
	DoWhileBegin(){
		String label = "whileStmt_" + this.globalCounter;
		globalCounter++;
		this.WhileStmtLabels.push(label);
		String endLabel = label + "_end";
		this.WhileStmtEndLabels.push(endLabel);
		myAsWriter.writeWhileLabel(label, endLabel);
		
	}
	
	void 
	DoWhileLoopCheck(STO s){
		myAsWriter.writeDoDesID(s);
		String label = this.WhileStmtLabels.pop();
		String endLabel = this.WhileStmtEndLabels.pop();
		myAsWriter.writeWhileLoopCheck(label, endLabel);
		
	}
	STO
	DoIfWhileExpr(STO expr)
	{
		if(expr.isError()){
			return expr;
		}
		if(expr.getType().isBool() || expr.getType().isInt())
			return expr;
		
		STO result = new ErrorSTO(Formatter.toString(ErrorMsg.error4_Test, 
				expr.getType().getName()));
		result.setType(new ErrorType("error",8));
		m_nNumErrors++;
		m_errors.print (result.getName());
		return result;
	}
	
	
	/**
	 * For project 2, if statement, check if the result, else go to Else block
	 * @param s
	 */
	void DoIfYesStmt(STO s){
		String label = "else_stmt_" + this.globalCounter;
		this.IfStmtElseLabels.push(label);
		this.globalCounter++;
		myAsWriter.writeIfStart(s, label);
	}
	
	/**
	 * For project 2, if statement yes branch end
	 */
	void DoIfYesStmtEnd(){
		String label = "end_if_stmt_" + this.globalCounter;
		this.globalCounter++;
		this.IfStmtEndLabels.push(label);
		myAsWriter.writeIfEnd(label);
	}
	
	/**
	 * For project 2, if statement totally end
	 * Write an label to indicate where the end of this if - else statement is
	 */
	void DoIfStmtEnd(){
		String label = this.IfStmtEndLabels.pop();
		myAsWriter.writeIfCompleteEnd(label);
	}
	
	void DoElseStmtStart(){
		String label = this.IfStmtElseLabels.pop();
		myAsWriter.writeIfCompleteEnd(label);
	}
	 

	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	STO
	DoFuncCall (STO sto, Vector<STO> arguments)
	{
		boolean errorArgument = false;
		if (!sto.isFunc() && !sto.getType().isFuncPointer())
		{
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.not_function, sto.getName()));
			return (new ErrorSTO (sto.getName ()));
		}
		if(sto.isError()){
			return sto;
		}
		if(sto.isFunc())
		{
			//Check if overloaded
			if(((FuncSTO)sto).isOverloaded())
			{
				FuncSTO tmp = (FuncSTO) sto;
				Vector<FuncSTO> candidates = tmp.getOverloadFuncList();
				candidates.addElement(tmp);
				
				for(FuncSTO s : candidates)
				{	
					Vector<STO> params = (Vector<STO>) s.getParameterSTO().clone();
					int count = 0;
					if(params.size() != arguments.size()){
						continue;
					}
					for(int i = 0; i < arguments.size(); i++)
					{
						//pass by reference, argument type is not equivalent to the parameter type
						if(!arguments.get(i).getType().isEquivalentTo(params.get(i).getType())){						
							break;
						}
						//pass by reference, argument is not a modifiable L-value
						else if(params.get(i).getType().isReference() && !arguments.get(i).isModLValue()){
							//If it's an array name, should be a mod l-val
							if(arguments.get(i).getType().isArray()){
								count++;
							}
							else
								break;
						}
						else{
							count++;
						}
					}
					//Check if a exact match
					if(count == arguments.size()){
						ExprSTO ret = new ExprSTO("FuncCall", s.getReturnType());
						if(tmp.getReturnType().isReference()){					
							ret.setIsAddressable(true);
							ret.setIsModifiable(true);
						}
						int originalOffset = m_symtab.getBytes();
						for (STO param : params){
							if(param.getType().isStruct() && !param.getType().isReference()){
								m_symtab.addBytes(param.getType().getSize());
							}
						}
						m_symtab.addBytes(tmp.getReturnType().getSize());
						myAsWriter.writeMakeFuncCall(arguments, s, m_symtab.getBytes(), this.globalCounter, params, originalOffset);
						globalCounter++;
						ret.setOffset("-" + m_symtab.getBytes());
						ret.setBase("%fp");
					    return ret;
					}
				}//End of if statement check argument size and parameter size
				//No good candidates
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error22_Illegal, sto.getName()));
				return (new ErrorSTO (sto.getName ()));
			}
			//End of checking overloading
			
			else{
			  //It's a FuncSTO, check number of arguments
			  FuncSTO tmp = (FuncSTO) sto;
			  //Check the number is the same
			  if(arguments.size() == tmp.getParameterNumbers()){
				Vector<STO> params = (Vector<STO>) tmp.getParameterSTO().clone();
				for(int i = 0; i < arguments.size(); i++)
				{
					if (params.get(i).getType().isReference() || params.get(i).getType().isArray()){
						//pass by reference, argument type is not equivalent to the parameter type
						if(!arguments.get(i).getType().isEquivalentTo(params.get(i).getType())){						
							m_nNumErrors++;
							m_errors.print (Formatter.toString(ErrorMsg.error5r_Call, 
							  arguments.get(i).getType().getName(), params.get(i).getName(), params.get(i).getType().getName()));
							errorArgument = true;
							continue;
							//return (new ErrorSTO ("DoFuncCall,  pass-by-reference error"));
						}
						
						//pass by reference, argument is not a modifiable L-value
						if(!arguments.get(i).isModLValue()){
							//If it's an array name, should be a mod l-val
							if(arguments.get(i).getType().isArray()){
								
							}
							else{
								m_nNumErrors++;
								m_errors.print (Formatter.toString(ErrorMsg.error5c_Call, 
										params.get(i).getName(), params.get(i).getType().getName()));
								errorArgument = true;

								//return (new ErrorSTO ("DoFuncCall,  pass-by-reference L-value error"));
							}
						}
					}
					//The argument is pass by value
					else{
						if(arguments.get(i).isError())
							return (new ErrorSTO ("DoFuncCall, pass-by-value error"));
						//If the type is not assignable
						if(arguments.get(i).getType().isArray() && params.get(i).getType().isArray()
							&&arguments.get(i).getType().isEquivalentTo(params.get(i).getType())){
							params.get(i).getType().setReference(true);
						}
						else{
							if(!arguments.get(i).getType().isAssignableTo(params.get(i).getType())){
								m_nNumErrors++;
								m_errors.print (Formatter.toString(ErrorMsg.error5a_Call, 
							  arguments.get(i).getType().getName(), params.get(i).getName(), params.get(i).getType().getName()));
								errorArgument = true;
								//return (new ErrorSTO ("DoFuncCall, pass-by-value error"));
							}
						}
					}
				}
				if(errorArgument)
					return (new ErrorSTO ("DoFuncCall, pass-by-value error"));
			    //The function evaluates to return type
				//Project 2, generate code for making function call
				ExprSTO ret = new ExprSTO("FuncCall", tmp.getReturnType());
				
				int originalOffset = m_symtab.getBytes();
				for (STO param : params){
					if(param.getType().isStruct() && !param.getType().isReference()){
						m_symtab.addBytes(param.getType().getSize());
					}
				}
				
				m_symtab.addBytes(tmp.getReturnType().getSize());
				if(tmp.getReturnType().isStruct() && !tmp.getReturnType().isReference()){
					ret.setOffset("64");
					ret.setBase("%sp");
				}
				else{
					ret.setOffset("-" + m_symtab.getBytes());
					ret.setBase("%fp");
				}
				myAsWriter.writeMakeFuncCall(arguments, tmp, m_symtab.getBytes(), this.globalCounter, params, originalOffset);
				globalCounter++;				
				//Return by reference, return a mod l-val
				if(tmp.getReturnType().isReference()){
					ret.setHoldAddress(true);
					ret.setIsAddressable(true);
					ret.setIsModifiable(true);
					return ret;
				}
				else if(tmp.getReturnType().isStruct()){
					ret.setHoldAddress(true);
				}
			    return ret;
			}
			else{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error5n_Call, arguments.size(), tmp.getParameterNumbers()));
				return (new ErrorSTO ("DoFuncCall, argument number"));
			}
		  }
		}
		//Here if the sto is varSTO and type is FunctionPointerType
		else{
			//It's a FuncSTO, check number of arguments
			FunctionPointerType t = ((FunctionPointerType)sto.getType());
			//Check the number is the same
			if(arguments.size() == t.getParameterNumbers()){
				Vector<STO> params = (Vector<STO>) t.getParameters().clone();
				for(int i = 0; i < arguments.size(); i++){
					if (params.get(i).getType().isReference() || params.get(i).getType().isArray()){
						//pass by reference, argument type is not equivalent to the parameter type
						if(!arguments.get(i).getType().isEquivalentTo(params.get(i).getType())){
							m_nNumErrors++;
							m_errors.print (Formatter.toString(ErrorMsg.error5r_Call, 
							  arguments.get(i).getType().getName(), params.get(i).getName(), params.get(i).getType().getName()));
							return (new ErrorSTO ("DoFuncCall,  pass-by-reference error"));
						}
						
						//pass by reference, argument is not a modifiable L-value
						if(!arguments.get(i).isModLValue()){
							//If it's an array name, should be a mod l-val
							if(arguments.get(i).getType().isArray()){
								
							}
							else{
								m_nNumErrors++;
								m_errors.print (Formatter.toString(ErrorMsg.error5c_Call, 
										params.get(i).getName(), params.get(i).getType().getName()));
								return (new ErrorSTO ("DoFuncCall,  pass-by-reference L-value error"));
							}
						}
					}
					//The argument is pass by value
					else{
						//If the type is not assignable
						if(!arguments.get(i).getType().isAssignableTo(params.get(i).getType())){
							
							m_nNumErrors++;
							m_errors.print (Formatter.toString(ErrorMsg.error5a_Call, 
							  arguments.get(i).getType().getName(), params.get(i).getName(), params.get(i).getType().getName()));
							return (new ErrorSTO ("DoFuncCall, pass-by-value error"));
						}
					}
				}
				
				 //The function evaluates to return type
				//Project 2, generate code for making function call
				ExprSTO ret = new ExprSTO("FuncCall", t.getReturnType());
				m_symtab.addBytes(t.getReturnType().getSize());
				
				myAsWriter.writeMakeFuncPtrCall(arguments, sto, m_symtab.getBytes(), this.globalCounter, params);
				globalCounter++;
				ret.setOffset("-" + m_symtab.getBytes());
				ret.setBase("%fp");
				 //The function evaluates to return type
				//Return by reference, return a mod l-val
				if(t.getReturnType().isReference()){
					ret.setHoldAddress(true);
					ret.setIsAddressable(true);
					ret.setIsModifiable(true);
					return ret;
				}
			    return ret;
			}
			else{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error5n_Call, arguments.size(), t.getParameterNumbers()));
				return (new ErrorSTO ("DoFuncCall, arugment number"));
			}
		}
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	STO
	DoDesignator2_Dot (STO sto, String strID)
	{
		if(sto.isError()){
			return sto;
		}
		// Good place to do the struct checks
        //check the type of sto is a struct type
		if(!(sto.getType().isStruct())){
			if(sto.getType().isPointer()){
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error14t_StructExp, ((PointerType)sto.getType()).getPrintedName() + "*"));
				return new ErrorSTO("ERROR");
			}
			else{
				m_nNumErrors++;
				m_errors.print (Formatter.toString(ErrorMsg.error14t_StructExp, sto.getType().getName()));
				return new ErrorSTO("ERROR");
			}
		}
		//check type of struct has no field named strID
		Vector<STO> fieldList = ((StructType)(sto.getType())).getField();
		boolean found = false;
		//Store the offset of the founded field
		int fieldOffset = 0;
		STO target = null;
		for(STO s: fieldList){
			if(strID.equals(s.getName())){
				found = true;	
				target = s;
				break;
			}
			fieldOffset += s.getType().getSize();
		}
		if(!found){
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.error14f_StructExp, strID,sto.getType().getName()));
		    return new ErrorSTO("ERROR");
		}
		//To write the field of the struct and pass in the struct sto and fieldoffset
		m_symtab.addBytes(4);
		boolean previous_reference = sto.getType().isReference();
		for (STO s : m_symtab.getFunc().getParameterSTO()){
			if(s.getName().equals(sto.getName())){
				sto.getType().setReference(true);
			}
		}
		myAsWriter.writeStructField(sto,fieldOffset, m_symtab.getBytes());

		sto.getType().setReference(previous_reference);
		//no error occur, return the StructSTO
		ExprSTO ret = new ExprSTO("dodes_dot", target.getType());
		ret.setIsModifiable(true);
		ret.setIsAddressable(true);
		ret.setBase("%fp");
		ret.setOffset("-" + m_symtab.getBytes());
		ret.setHoldAddress(true);
        
		//int offset = Integer.parseInt(sto.getOffset()) + fieldOffset;
		
		return ret;
	}


	Type
	DoArrayDeclCheck(STO sto){
		if(sto.isError())
		{
			return new ErrorType("error", 4);
		}
		//Check if the type of index expression is equivalent to int
		if(!(sto.getType().isEquivalentTo(new IntType("int", 4)))){
			m_nNumErrors++;
		 	m_errors.print (Formatter.toString(ErrorMsg.error10i_Array, sto.getType().getName()));	
		 	return new ErrorType("error", 4);
		}
		//Check if the value of the index expression is not known at compile time
		if(!(sto.isConst())){
			m_nNumErrors++;
		 	m_errors.print(ErrorMsg.error10c_Array);	
		 	return new ErrorType("error", 4);
		}
		//Check if the value of the index expression is not greater than 0
		if(((ConstSTO)sto).getIntValue() <= 0){
			m_nNumErrors++;
		 	m_errors.print(Formatter.toString(ErrorMsg.error10z_Array,((ConstSTO)sto).getIntValue()));	
		 	return new ErrorType("error", 4);
		}
		
		ArrayType t = new ArrayType("array", 4);
		t.setArraySize(((ConstSTO)sto).getIntValue());
		return t;
	}
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	STO
	DoDesignator2_Array (STO nameSto, STO indexExpr)
	{
		if(nameSto.isError()){
			return nameSto;
		}
		if(indexExpr.isError() ){
			return indexExpr;
		}
		if(nameSto.getType().isNullPointer()){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error11t_ArrExp,nameSto.getType().getName()));	
			return new ErrorSTO("error");
		}
		// Good place to do the array checks
		//Check the type of designator precding any [] operator is not an array or pointer type
		if(!(nameSto.getType().isArray()) && !(nameSto.getType().isPointer())){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error11t_ArrExp,nameSto.getType().getName()));	
			return new ErrorSTO("error");
		}
		
	    //Check the type of the index expression is not equivalent to int
		if(!(indexExpr.getType().isEquivalentTo(new IntType("int",4)))){
			m_nNumErrors++;
			m_errors.print(Formatter.toString(ErrorMsg.error11i_ArrExp,indexExpr.getType().getName()));	
			return new ErrorSTO("error");
		}
		//Check if the index expression is a constant, an error should generate if the index is 
		//outside the bounds of the array
		if(nameSto.getType().isArray()){
			if(indexExpr.isConst()){
				if(((ConstSTO) indexExpr).getIntValue() >= ((ArrayType)nameSto.getType()).getArraySize() || 
				   ((ConstSTO) indexExpr).getIntValue() < 0){
					m_nNumErrors++;
					m_errors.print(Formatter.toString(ErrorMsg.error11b_ArrExp,((ConstSTO) indexExpr).getIntValue(),((ArrayType)nameSto.getType()).getArraySize()));	
					return new ErrorSTO("error");
				}	
		    }
		}
		ExprSTO e = new ExprSTO("array_doDesignator2", ((CompositeType)nameSto.getType()).getElementType());
		e.setIsAddressable(true);
		e.setIsModifiable(true);
		m_symtab.addBytes(4);
		boolean previous_reference = nameSto.getType().isReference();
		for (STO s : m_symtab.getFunc().getParameterSTO()){
			if(s.getName().equals(nameSto.getName())){
				nameSto.getType().setReference(true);
			}
		}
		myAsWriter.writeDoArrayDes(nameSto, indexExpr, m_symtab.getBytes(), this.globalCounter);
		nameSto.getType().setReference(previous_reference);
		globalCounter++;
		e.setOffset("-" + m_symtab.getBytes());
		e.setBase("%fp");
		if(((CompositeType)nameSto.getType()).getElementType().isPointer()){
			e.setHoldAddress(false);
		}
		else{
			e.setHoldAddress(true);
		}
		//Correct usage of array, dereference the array and get its element type
		return e;
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	STO
	DoDesignator3_ID (String strID)
	{
		STO		sto;
		if ((sto = m_symtab.access (strID)) == null)
		{
			m_nNumErrors++;
		 	m_errors.print (Formatter.toString(ErrorMsg.undeclared_id, strID));	
			sto = new ErrorSTO (strID);
		}
		if(sto.getType().isInt() || sto.getType().isFloat() || sto.getType().isBool())
			myAsWriter.writeDoDesID(sto);
		return (sto);
	}
	
	//Check #0, global variable check
	STO
	DoDesignator3_Global_ID (String strID)
	{
		STO sto;
		if((sto = m_symtab.accessGlobal(strID)) == null)
		{
			m_nNumErrors++;
		 	m_errors.print (Formatter.toString(ErrorMsg.error0g_Scope, strID));	
			sto = new ErrorSTO (strID);
		}
		sto.setIsGlobal(true);
		myAsWriter.writeDoDesID(sto);
		return (sto);
	}

	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	STO
	DoQualIdent (String strID)
	{
		STO		sto;

		if ((sto = m_symtab.access (strID)) == null)
		{
			m_nNumErrors++;
		 	m_errors.print (Formatter.toString(ErrorMsg.undeclared_id, strID));	
			return (new ErrorSTO (strID));
		}

		if (!sto.isTypedef())
		{
			m_nNumErrors++;
			m_errors.print (Formatter.toString(ErrorMsg.not_type, sto.getName ()));
			return (new ErrorSTO (sto.getName ()));
		}
		return (sto);
	}


//----------------------------------------------------------------
//	Instance variables
//----------------------------------------------------------------
	private Lexer			m_lexer;
	private ErrorPrinter	m_errors;
	private int 			m_nNumErrors;
	private String			m_strLastLexeme;
	private boolean			m_bSyntaxError = true;
	private int			m_nSavedLineNum;
    private AssemblyCodeGenerator myAsWriter;
	private SymbolTable		m_symtab;
	private Vector<ConstSTO> coutStrings = new Vector<ConstSTO>();
	private Stack<String> IfStmtEndLabels = new Stack<String>();
	private Stack<String> IfStmtElseLabels = new Stack<String>();
	private Stack<Integer> decltypeLabels = new Stack<Integer>();
	private int globalCounter = 0;
	private Stack<String> WhileStmtLabels = new Stack<String>();
	private Stack<String> WhileStmtEndLabels = new Stack<String>();
	private Stack<String> OrShortCircuitLabel = new Stack<String>();
	private Stack<String> AndShortCircuitLabel = new Stack<String>();
	private int decltypeCurrentCount;
}
