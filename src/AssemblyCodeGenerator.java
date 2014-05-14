import java.util.Vector;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Date;

/**
 * An Assembly Code Generator example emphasizing well thought design and
 * the use of java 1.5 constructs.
 * 
 * Disclaimer : This is not code meant for you to use directly but rather
 * an example from which I hope you can learn useful constructs and
 * conventions.
 * 
 * Topics of importance (Corrosponding to the inline comment numbers below)
 * 
 * 1) We will use this variable to denote the current level of indentation.
 *    For assembly there is usually only one or two levels of nesting.
 * 
 * 2) A collection of static final error messages.  This isn't so important in
 *    your project but is useful.  The static keyword means we only make 3 
 *    strings, shared across potentially multiple AssemblyCodeGenerator(s).
 *    It is Java convention to spell constant variables with upper casing.
 *    
 * 3) FileWriter is a basic IO class which can write basic types such as
 *    Strings to a file.  For performance you may want to look into the
 *    BufferedWriter class.
 *    
 * 4) This is a template for our file header.  It is very basic consisting only
 *    of a time stamp.
 *    
 * 5) This is the string we will use as an indentation seperator.  We are 
 *    encapsulating this seperator into one variable so we only need to change
 *    the initialization if we want to change our spacing to say 4 spaces for
 *    example.  Imagine if you simply used the literal "\t" in 500 places and
 *    then you decide you want to change it to 4 spaces!  Aside from regular 
 *    expressions you have a lot of work ahead of you.
 *    
 * 6) These are constant String templates that will be used for code
 *    generation.  It is nice to isolate these in one place or even in another
 *    file so that we can quickly make universal changes if needed.  You will
 *    notice that we could generate an entirely different language by simply
 *    changing the construct definitions.  I recommend defining all operations
 *    as well as formats.  Operations are things like add, mul, set, etc.
 *    Formats are like {OPERATION} {REG_1}, {REG_2}, {REG_3} etc.
 *    
 * 7) Here we are making a call to writeAssembly to write our header with the
 *    current time.  writeAssembly explained later.
 *    
 * 8) These methods are used to increase or decrease our current indentation
 *    level.  You might ask why make a method for a simple inc/dec?  We are
 *    encapsulating the notion of adjusting indentation.  It just so happens
 *    that this current implementation is just a variable increment or 
 *    decrement, but who is to say that the operation won't be more advanced
 *    in the future.  Maybe we want to log a message everytime we increment
 *    or decrement indentation.  We wouldn't want to add the logging code
 *    everywhere we were incrementing the variable (if we didn't have the
 *    methods).
 *    
 * 9) This signature may look foreign to you.  What is says is that we have 
 *    public method named writeAssembly which takes as parameters a String
 *    followed by 1 or more strings.  This construct is called "VarArgs" and
 *    is a Java 1.5 feature.  This allows you to write one method which can
 *    be applied to any number of parameters.  This method simply takes in 
 *    a template and all the strings that will be substituted into the 
 *    template.  When you are actually in the method, the parameter 
 *    String ... params will be an array of strings.
 *    
 * 10) This is where we use our indent_level.  We will indent indent_level levels
 *     of indentation.  That is an awkward sentence isn't it!  StringBuilder is
 *     an efficient class to build strings from concatentations.  If your 
 *     concatenations span multiple lines of code, using a StringBuilder can
 *     offer signifigant performance when compared to using the + operator.
 *     This topic can get fairly detailed, send me an email or come talk to me
 *     in the lab for more details.
 * 
 * 11) Here we are writing the message to file, notice we are using the 
 *     String.format method which takes a printf like format string followed
 *     by an array of Objects which are the parameters to the format string.
 *     
 * 12) Main is just a small demo that will create a tiny assembly file in the
 *     current directory called "output.s".  This file doesn't compile and is
 *     not meant to.
 * 
 * @author Evan Worley
 */

public class AssemblyCodeGenerator {
    // 1
    private int indent_level = 0;
    
    // 2
    private static final String ERROR_IO_CLOSE = 
        "Unable to close fileWriter";
    private static final String ERROR_IO_CONSTRUCT = 
        "Unable to construct FileWriter for file %s";
    private static final String ERROR_IO_WRITE = 
        "Unable to write to fileWriter";

    // 3
    private FileWriter fileWriter;
    
    // 4
    private static final String FILE_HEADER = 
        "/*\n" +
        " * Generated %s\n" + 
        " */\n\n";
        
    // 5
    public static final String SEPARATOR = "\t";
    
    // 6
    public static final String SET_OP = "set";
    public static final String TWO_PARAM = "%s" + SEPARATOR + "%s, %s\n";

    public AssemblyCodeGenerator(String fileToWrite) {
        try {
            fileWriter = new FileWriter(fileToWrite);
            
            // 7
            writeAssembly(FILE_HEADER, (new Date()).toString());
        } catch (IOException e) {
            System.err.printf(ERROR_IO_CONSTRUCT, fileToWrite);
            e.printStackTrace();
            System.exit(1);
        }
    }
    

    // 8
    public void decreaseIndent() {
        indent_level--;
    }
    
    public void dispose() {
        try {
            fileWriter.close();
        } catch (IOException e) {
            System.err.println(ERROR_IO_CLOSE);
            e.printStackTrace();
            System.exit(1);
        }
    }
    
    public void increaseIndent() {
        indent_level++;
    }
    
    public void writeData(){
      String template = "";
      template += indentString();
      template += ".section \".data\"\n";
      flush(template);
    }

    public void writeText(){
      String template = "";
      template += indentString() + ".section \".text\"\n";
      flush(template);
    }
    public void writeBss(){
      String template = "";
      template += indentString();
      template += ".section \".bss\"\n";
      flush(template);
    }

    public String writeAlignment(int size){
      String template = "";
      template += indentString();
      template += ".align " + size + "\n";
      return template;
    }
    public String writeGlobalLabel(STO variable){
      String template = "";
      //if variable is a VarSTO
      if(variable.isVar()){
	    VarSTO tmp = (VarSTO)variable;
        if(tmp.getInit() != null){
	      writeData();
	      if(tmp.getType().isInt() || tmp.getType().isBool()){
            template += tmp.getOffset() + ":" + SEPARATOR + ".word ";
	        template += ((ConstSTO)tmp.getInit()).getIntValue() + "\n\n"; 
          }
	      else if(tmp.getType().isFloat()){
	        template += tmp.getOffset() + ":" + SEPARATOR + ".single ";
	        template += "0r" + ((ConstSTO)tmp.getInit()).getFloatValue() +"\n\n";
	      }
        }
        //No init
        else{
	      writeBss();
          template += variable.getOffset() + ":" + SEPARATOR + ".skip " + variable.getType().getSize() + "\n\n";
        }
      }
      else if(variable.isConst()){
	    ConstSTO tmp = (ConstSTO)variable;
	    template += indentString() + ".section \".data\"\n";
	    if(tmp.getType().isInt() || tmp.getType().isBool()){
          template += tmp.getOffset() + ":" + SEPARATOR + ".word ";
	      template += tmp.getIntValue() + "\n\n"; 
      	}
	    else if(tmp.getType().isFloat()){
	      template += tmp.getOffset() + ":" + SEPARATOR + ".single ";
	      template += "0r" + tmp.getFloatValue() +"\n\n";
	    }
      }
      return template;
    }
    
    public void writeStringFormat(){
      String template = "";
      template += indentString();
      template += ".section \".rodata\"\n";
      template += "_endl:\t\t.asciz \"\\n\"\n";
      template += "_intFmt:\t.asciz \"%d\"\n";
      template += "_strFmt:\t.asciz \"%s\"\n";
      template += "_boolT:\t\t.asciz \"true\"\n";
      template += "_boolF:\t\t.asciz \"false\"\n\n";
      flush(template);
      template = indentString() + ".section \".text\"\n";
      template += indentString() + ".align 4\n";
      template += "value_one:\t.single 0r1.0\n";
      flush(template);
    }

    public String indentString(){
      String ret = "";
      for(int i = 0; i < indent_level; i++){
        ret += SEPARATOR;
      }
      return ret;
    }
    public void writeGlobal(STO sto){
      String template = "";
      if(sto.isVar()){
        sto = (VarSTO)sto;
	    template += indentString();
        template += ".global\t";
        template += sto.getOffset() + "\n";
        template += writeAlignment(4);
        template += writeGlobalLabel(sto);
        flush(template);
      }
      else if(sto.isConst()){
        template += indentString();
	    template += ".global\t";
	    template += sto.getOffset() + "\n";
	    template += writeAlignment(4);
	    template += writeGlobalLabel(sto);
	    flush(template);
      }
    }
    public void writeStatic(STO sto, String label){
      String template = "";
      template += writeAlignment(4);
      
      //if variable is a VarSTO
      if(sto.isVar()){
	    VarSTO tmp = (VarSTO)sto;
        if(tmp.getInit() != null){
	      writeData();
	      if(tmp.getType().isInt() || tmp.getType().isBool()){
            template += label + ":" + SEPARATOR + ".word ";
	        template += ((ConstSTO)tmp.getInit()).getIntValue() + "\n\n"; 
          }
	      else if(tmp.getType().isFloat()){
	        template += label + ":" + SEPARATOR + ".single ";
	        template += "0r" + ((ConstSTO)tmp.getInit()).getFloatValue() +"\n\n";
	      }
        }
        //No init
        else{
	      writeBss();
          template += label + ":" + SEPARATOR + ".skip " + sto.getType().getSize() + "\n\n";
        }
      }
      else if(sto.isConst()){
	    ConstSTO tmp = (ConstSTO)sto;
	    template += indentString() + ".section \".data\"\n";
	    if(tmp.getType().isInt() || tmp.getType().isBool()){
          template += label + ":" + SEPARATOR + ".word ";
	      template += tmp.getIntValue() + "\n\n"; 
      	}
	    else if(tmp.getType().isFloat()){
	      template += label + ":" + SEPARATOR + ".single ";
	      template += "0r" + tmp.getFloatValue() +"\n\n";
	    }
      }    
      flush(template);
    }

    public void writeConstFolding(STO sto){
    	String template = "";
    	if(sto.getType().isInt()){
    		template += indentString() + "set\t" + ((ConstSTO)sto).getIntValue() + ", " + "%l0\n";
    	}
    	else if (sto.getType().isFloat()){
    		writeData();
	        flush(writeAlignment(4));
    	}
    		
    	flush(template);
    }
    public void writeLocal(String functionName, int globalCounter, VarSTO sto){
      String template = "";
      if(sto.getInit() == null){
	    template += "! local variable:   " + sto.getName() + "    without init, just add offset\n";
      }
      else{
    	flush("! init variable: " + sto.getName() + "\n");
	    if(sto.getInit().isConst()){
	      if(sto.getType().isInt()){
	        template += indentString() + "set\t" + ((ConstSTO)sto.getInit()).getIntValue() + ", " + "%l1\n";
	        template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
	        template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
		    template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";	
	      }
	      else if(sto.getType().isBool()){
	    	template += indentString() + "set\t" + ((ConstSTO)sto.getInit()).getIntValue() + ", " + "%l1\n";
		    template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
		    template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
			template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";	
	      }
	      //If it's a float, put the value in the data segment.
	      else if(sto.getType().isFloat()){
	    	writeData();
	        flush(writeAlignment(4));
	        String label = functionName + "_f_" + globalCounter;
	        flush(label + ":\t" + ".single " + "0r" + ((ConstSTO)sto.getInit()).getFloatValue() + "\n");
	        //Go back to text segment
	        writeText();
	        flush(writeAlignment(4));
	    	template += indentString() + "set\t" + label + ", " + "%l1\n";
	    	template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
	    	template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
	    	template += indentString() + "ld\t" + "[%l1], %l1\n";
	    	template += indentString() + "st\t" + "%l1, [%l0]\n\n";
	      }
	    }//Check if init is const
	    //Enter here if init is not const
	    else if(sto.getInit().isVar()){
	      if(sto.getInit().getIsGlobal() == true){
	    	STO init = sto.getInit();
	    	template += indentString() + "set\t" + init.getOffset() + ", " + "%l0\n";
		    template += indentString() + "add\t" + init.getBase() + ", %l0, %l0\n";
		    template += indentString() + "ld\t" + "[%l0], %l1" + "\n";
	        template += indentString() + "set\t" + sto.getOffset() + ", %l0\n";
	        template += indentString() + "add\t" + sto.getBase() + ",%l0, %l0\n";
	        template += indentString() + "st\t" + "%l1, [%l0]\n\n";
	      }
	      //Not a global
	      else{
	    	STO init = sto.getInit();
		    template += indentString() + "set\t" + init.getOffset() + ", " + "%l0\n";
			template += indentString() + "add\t" + init.getBase() + ", %l0, %l0\n";
			template += indentString() + "ld\t" + "[%l0], %l1" + "\n";
		    template += indentString() + "set\t" + sto.getOffset() + ", %l0\n";
		    template += indentString() + "add\t" + sto.getBase() + ",%l0, %l0\n";
		    template += indentString() + "st\t" + "%l1, [%l0]\n\n";
	      }
	    }
	    else if(sto.getInit().isExpr()){
	      flush("! init is an expression\n");
	      STO init = sto.getInit();
	      template += indentString() + "set\t" + init.getOffset() + ", " + "%l0\n";
	      template += indentString() + "add\t" + init.getBase() + ", %l0, %l0\n";
		  template += indentString() + "ld\t" + "[%l0], %l1" + "\n";
		  template += indentString() + "set\t" + sto.getOffset() + ", %l0\n";
		  template += indentString() + "add\t" + sto.getBase() + ",%l0, %l0\n";
		  template += indentString() + "st\t" + "%l1, [%l0]\n\n";
	      
	    }
      }
      flush(template);
    }
    
    public void writeConstLocal(String functionName, int globalCounter, ConstSTO sto){
      String template = "";
      template += "! Const local\n";   
   	  
   	  if(sto.getType().isInt()){
   	    template += indentString() + "set\t" + sto.getIntValue() + ", " + "%l1\n";
   	    template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
   	    template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
   		template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";	
   	  }
   	  else if(sto.getType().isBool()){
   	    template += indentString() + "set\t" + sto.getIntValue() + ", " + "%l1\n";
   		template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
   		template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
   	    template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";	
   	  }
   	  //If it's a float, put the value in the data segment.
   	  else if(sto.getType().isFloat()){
   	    writeData();
   	    flush(writeAlignment(4));
   	    String label = functionName + "_f_c_" + globalCounter;
   	    flush(label + ":\t" + ".single " + "0r" + sto.getFloatValue() + "\n");
   	    //Go back to text segment
   	    writeText();
   	    flush(writeAlignment(4));
   	    template += indentString() + "set\t" + label + ", " + "%l1\n";
   	    template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
   	    template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
   	    template += indentString() + "ld\t" + "[%l1], %l1\n";
   	    template += indentString() + "st\t" + "%l1, [%l0]\n\n";
   	  }
      flush(template);
    }
    public void writeDoDesID(STO sto){
      String template = "! indodesID : " + sto.getName() + "\n";
      if(sto.isVar()){
    	  if(sto.getType().isFloat()){
    		template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
  		    template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
  		    template += indentString() + "ld\t" + "[%l0], %f0\n";
  		    template += indentString() + "ld\t" + "[%l0], %l0\n\n";
    	  }else{
    	    template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
		    template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
		    template += indentString() + "ld\t" + "[%l0], %l0" + "\n\n";
    	  }
    	  //Check if it's reference, if so, need to do another load
    	  if(sto.getType().isReference()){	  
    		  template += "! " + sto.getName() + " reference variable, need to load one more time\n";
    		  template += indentString() + "ld\t[%l0], %l0\n";
    	  }
      }
      else if(sto.isExpr()){
    	  if(sto.getType().isFloat()){
      		template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
    		template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
    		template += indentString() + "ld\t" + "[%l0], %f0\n";
  		    template += indentString() + "ld\t" + "[%l0], %l0\n\n";
      	  }else{
      	    template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
  		    template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
  		    template += indentString() + "ld\t" + "[%l0], %l0" + "\n\n";
      	  }
    	  //Check if it's reference, if so, need to do another load
    	  if(sto.getType().isReference()){	  
    		  template += "! " + sto.getName() + " reference variable, need to load one more time\n";
    		  template += indentString() + "ld\t[%l0], %l0\n";
    	  }
      }
      
      flush(template);
    }
    
    public void writeConstIntTol0(int x){
      String template = indentString() + "set\t" + x + ", %l0\n";
      flush(template);
    }
    public void writeConstFloatTol0(float y, int globalCounter){
      writeData();
      flush(writeAlignment(4));
      String label =  "const_f_" + globalCounter;
      flush(label + ":\t" + ".single " + "0r" + y + "\n");
      writeText();
      flush(writeAlignment(4));
      String template = indentString() + "set\t" + label + ", %l0\n";
      template += indentString() + "ld\t[%l0], %f0\n";
      flush(template);
    }
    /**
     * This method is for cout << a << endl; where a is an int, it will load the value from %l0
     */
    public void writeCoutInt(){
      String template = indentString() + "set\t_intFmt, %o0\n";
      template += indentString() + "mov\t%l0, %o1\n";
      template += indentString() + "call\tprintf\n";
      template += indentString() + "nop\n";
      flush(template);
    }
    /**
     * This is combined use with writeConstFloatTol0, which put the value into %f0 for printing
     */
    public void writeCoutFloat(){
      String template = indentString() + "call\tprintFloat\n";
      template += indentString() + "nop\n";
      flush(template);
    }
    public void writeCoutBool(int globalCounter){
      String template = indentString() + "cmp\t%l0, 0\n";
      template += indentString() + "be\tsetFalse"+globalCounter + "\n";
      template += indentString() + "nop\n";
      template += indentString() + "set\t_boolT, %o0\n";
      template += indentString() + "call\tprintf\n";
      template += indentString() + "nop\n";
      template += indentString() + "ba\tdone" + globalCounter + "\n";
      template += indentString() + "nop\n";
      
      template += "setFalse"+globalCounter+":\n";
      template += indentString() + "set\t_boolF, %o0\n";
      template += indentString() + "call\tprintf\n";
      template += indentString() + "nop\n";
      template += "done" + globalCounter + ":\n";
      flush(template);
    }
    
    public void flush(String str){
      try{
        fileWriter.write(str);
      }
      catch(IOException e){
        System.err.println(ERROR_IO_WRITE);
	    e.printStackTrace();
      }

    }
    public void writeFunc(FuncSTO sto){
      String template = "";
      //Function label
      template += indentString() + ".section \".text\"\n";
      template += indentString() + ".align 4\n";
      template += indentString() + ".global " + sto.getName() + "\n";
      template += sto.getName() + ":\n";
      //Indent the string
      template += indentString();
      template += "set\t" + "SAVE." + sto.getName() + ", " + "%g1\n";
      template += indentString();
      template += "save\t" + "%sp, " + "%g1, " + "%sp\n";
      flush(template);
    }
    
    public void writeSaveSpace(FuncSTO sto, int bytes){
      String template = "";
      template += "! from DoFuncDecl2\n";
      template += indentString() + "SAVE." + sto.getName();
      if(bytes == 0){
        template += " = -92 & -8\n";
      }
      else{
	template += " = -(92 + " + bytes +") & -8\n";
      }
      flush(template);
    }
    
    public void writeRetRestore(){
      String template = indentString() + "ret\n";
      template += indentString() + "restore\n\n";
      flush(template);
    }
    
    /**
     * This method takes in an constSTO and then check its base type and put the value into %l0
     * @param functionName
     * @param s
     * @param globalCounter
     */
    public void setConst(String functionName, ConstSTO s, int globalCounter){
    	String template = "";
    	if(s.getType().isInt()){
    		template += indentString() + "set\t" + s.getIntValue() + ", " + "%l0\n";
    	}
    	else if(s.getType().isBool()){
    		template += indentString() + "set\t" + s.getIntValue() + ", " + "%l0\n";
    	}
    	else if(s.getType().isFloat()){
    		writeData();
  	        flush(writeAlignment(4));
  	        String label = functionName + "_f_return_" + globalCounter;
  	        flush(label + ":\t" + ".single " + "0r" + s.getFloatValue() + "\n");
  	        //Go back to text segment
  	        writeText();
  	        flush(writeAlignment(4));
  	    	template += indentString() + "set\t" + label + ", " + "%l0\n";
  	    	//This load the value to %f0 since it's useful for float operation
  	    	template += indentString() + "ld\t[%l0], %f0\n";
  	    	template += indentString() + "ld\t[%l0], %l0\n";
    	}
    	flush(template);
    }
    
    /**
     * This is for writing assembly code for moving the return value to %o0
     * @param funcName
     * @param s
     * @param globalCounter
     */
    public void writeReturnStmt(String funcName, STO s, int globalCounter){
      if(s.getType().isVoid()){
    	  System.out.println("return void");
    	  return;
      }
      if(s.isConst()){
    	setConst(funcName, (ConstSTO)s, globalCounter);
      }
      else{
    	writeDoDesID(s);
      }
      flush("! return stmt\n");
      String template = indentString() + "mov\t%l0, %i0\n";
      flush(template);
    }
    
    /**
     * 2.3 function call with parameters
     * @param s
     * @param index
     */
    public void writeFormalParam(STO s, int index){
    	String template = "\n\n! storing " + index + "th element onto stack\n";
    	template += indentString() + "set\t" + s.getOffset() + ", %l0\n";
    	template += indentString() + "add\t" + s.getBase() + ", %l0, %l0\n";
    	template += indentString() + "st\t%i" + index + ", [%l0]\n";
    	flush(template);
    }
    public void writeMakeFuncCall(Vector<STO> arguments, FuncSTO function, int offset, int globalCounter, Vector<STO> params){
      //No argument function call
      String template = "\n\n! making function call :" + function.getName() + "\n";
      if(arguments.size() == 0){
    	template += indentString() + "call\t" + function.getName() + "\n";
    	template += indentString() + "nop\n";
      }
      //Argument is not 0
      else{    	 
    	  template += "! moving all the arguments into %o registers\n";
    	  flush(template);
    	  for(int i = 0; i < arguments.size(); i++){
    		  if(arguments.elementAt(i).isConst()){
    			  setConst("MakingFuncCall", (ConstSTO)arguments.elementAt(i), globalCounter);
    		  }  		 
    		  else{
    			  //Check if it's reference, if so, pass the address of that variable
    			  if(params.elementAt(i).getType().isReference()){
    				  flush("! argument pass by reference, get the address\n");
    				  flush(indentString() + "set\t" + arguments.elementAt(i).getOffset() + ", " + "%l0\n");
    			  	  flush(indentString() + "add\t" + arguments.elementAt(i).getBase() + ", %l0, %l0\n");
    			  }
    			  else
    				  writeDoDesID(arguments.elementAt(i));
    		  }
    		  template = "! " + i + "th argument of this function\n";
    		  template += indentString() + "mov\t%l0, %o" + i + "\n";
    		  flush(template);
    		  template = "";
    	  }
    	  template += indentString() + "call\t" + function.getName() + "\n";
      	  template += indentString() + "nop\n";
    	  
      }
      template += "! Store return to a local tmp\n";
      template += indentString() + "st\t%o0, [%fp-" + offset + "]\n\n";
      flush(template);
      
    }
    
    
    public void writeCout(String funcName, int x, String str){
      String template = "";
      template += indentString() + "set\t_strFmt, %o0\n";
      //x represent the number of string it is in the list, which we will put in
      //the .rodata later
      template += indentString() + "set\t" + funcName + (x-1) + ", %o1\n";
      template += indentString() + "call\tprintf\n";
      template += indentString() + "nop\n\n";
      
      template += indentString() + ".section \".rodata\"\n";
      template += writeAlignment(4);
      template += funcName + (x-1) + ":\t" + ".asciz " + "\"" + str + "\"\n\n";
      flush(template);
      writeText();
      flush(writeAlignment(4)+"\n");
    }
    
    public void writeEndl(){
      String template = "";
      template += indentString() + "set\t_endl, %o0\n";
      template += indentString() + "call\tprintf\n";
      template += indentString() + "nop\n\n";
      flush(template);
    }
    
    public void writeStrings(String funcName, Vector<ConstSTO> lst){
      String template = "";
      template += indentString() + ".section \".rodata\"\n";
      for(int i = 0; i < lst.size(); i++){
        template += funcName + i + ":\t" + ".asciz ";
	String tmp = "\"" + lst.elementAt(i).getName() + "\"";
	template += tmp + "\n";
      }
      template += "\n";
      flush(template);
    }
    
    
    
    public void writeNegative(int offset, STO s){
        flush("! convert to negative and store\n");
        writeDoDesID(s);
        if(s.getType().isInt()){
	        String template = indentString() + "mov\t%l0, %o0\n";
	        template += indentString() + "set\t-1, %o1\n";
	        template += indentString() + "call\t.mul\n";
	        template += indentString() + "nop\n";
	        template += indentString() + "st\t%o0, [%fp-" + offset + "]\n";
	        template += indentString() + "ld\t[%fp-" + offset +"], %l0\n\n";
	        flush(template);
        }
        //If it's float
        else{
        	String template = indentString() + "fnegs\t%f0, %f0\n";
	        template += indentString() + "st\t%f0, [%fp-" + offset + "]\n";
	        template += indentString() + "ld\t[%fp-" + offset + "], %l0\n\n";
	        template += indentString() + "ld\t[%fp-" + offset + "], %f0\n\n";
	        flush(template);
        }
      }
    public void getValueIntof1(STO a, int globalCounter, int offset){
    	String template = "";
    	//Prompt to float
    	if(a.getType().isInt()){
    		if(a.isConst()){
    			setConst("", (ConstSTO)a, 0);
    			template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
    			template += indentString() + "ld\t[%fp-" + offset + "], %f0\n";
    			template += indentString() + "fitos\t%f0, %f1\n";
    		}
    		else{
    			writeDoDesID(a);
    			template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
    			template += indentString() + "ld\t[%fp-" + offset + "], %f0\n";
    			template += indentString() + "fitos\t%f0, %f1\n";
    		}
    	}else{
    		if(a.isConst()){
    			setConst("getValueTo_f1", (ConstSTO)a, globalCounter);
    			template += indentString() + "fmovs\t%f0, %f1\n";
    		}
    		else{
    			writeDoDesID(a);
    			template += indentString() + "fmovs\t%f0, %f1\n";
    		}
    	}
    	flush(template);
    }
    public void getValueIntof2(STO b, int globalCounter, int offset){
    	String template = "";
    	//Prompt to float
    	if(b.getType().isInt()){
    		if(b.isConst()){
    			setConst("", (ConstSTO)b, 0);
    			template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
    			template += indentString() + "ld\t[%fp-" + offset + "], %f0\n";
    			template += indentString() + "fitos\t%f0, %f2\n";
    		}
    		else{
    			writeDoDesID(b);
    			template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
    			template += indentString() + "ld\t[%fp-" + offset + "], %f0\n";
    			template += indentString() + "fitos\t%f0, %f2\n";
    		}
    	}else{
    		if(b.isConst()){
    			setConst("getValueTo_f2", (ConstSTO)b, globalCounter);
    			template += indentString() + "fmovs\t%f0, %f2\n";
    		}
    		else{
    			writeDoDesID(b);
    			template += indentString() + "fmovs\t%f0, %f2\n";
    		}
    	}
    	flush(template);
    }
    public void writeAddOp(int offset, STO a, STO b, int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	      if(a.isVar())
	        writeDoDesID(a);
	      else if (a.isConst())
	    	flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0\n");
	      else if(a.isExpr())
	    	writeDoDesID(a);
	      
	      String template = "! adding first operand:" + a.getName() + " to %l1\n";
	      template += indentString() + "mov\t%l0, %l1\n\n";
	      flush(template);
	      
	      if(b.isVar())
	        writeDoDesID(b);
	      else if (b.isConst())
	    	flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0\n");
	      else if(b.isExpr())
	    	writeDoDesID(b);
	      template = "! adding second operand:" + b.getName() + " to %l2\n";
	      template += indentString() + "mov\t%l0, %l2\n\n";
	      flush(template);
	      //Do the addop part
	      template = indentString() + "add\t%l1, %l2, %l0\n";
	      template += indentString() + "st\t%l0, [%fp" + "-" + offset + "]\n";
	      flush(template);
      }
      //If one of the operand is float
  	  else if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
  		int position_to_store_tmp = offset - 4;
  		getValueIntof1(a, globalCounter, position_to_store_tmp);
  		getValueIntof2(b, globalCounter, position_to_store_tmp);
  		String template = "! adding %f1 & %f2 to %f0\n";
  		template += indentString() + "fadds\t%f1, %f2, %f0\n";
  		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
	    flush(template);
      }
      //Float add float
  	  else{
  		getValueIntof1(a, globalCounter, offset);
  		getValueIntof2(b, globalCounter, offset);
  		String template = "! adding %f1 & %f2 to %f0\n";
  		template += indentString() + "fadds\t%f1, %f2, %f0\n";
  		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
	    flush(template);
      }
    }
    
    public void writeMinusOp(int offset, STO a, STO b, int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	        if(a.isVar())
	          writeDoDesID(a);
	        else if (a.isConst())
	        	flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0\n");
	        else if(a.isExpr())
	        	writeDoDesID(a);
	        
	        String template = "! minusOP first operand:" + a.getName() + " to %l1\n";
	        template += indentString() + "mov\t%l0, %l1\n\n";
	        flush(template);
	        
	        if(b.isVar())
	          writeDoDesID(b);
	        else if (b.isConst())
	      	  flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0\n");
	        else if(b.isExpr())
	      	  writeDoDesID(b);
	        template = "! minusOP second operand:" + b.getName() + " to %l2\n";
	        template += indentString() + "mov\t%l0, %l2\n\n";
	        flush(template);
	        //Do the subop part
	        template = indentString() + "sub\t%l1, %l2, %l0\n";
	        template += indentString() + "st\t%l0, [%fp" + "-" + offset + "]\n";
	        flush(template);
    	}
    	//If one of the operand is float
    	else if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
    		int position_to_store_tmp = offset - 4;
    		getValueIntof1(a, globalCounter, position_to_store_tmp);
    		getValueIntof2(b, globalCounter, position_to_store_tmp);
    		String template = "! adding %f1 & %f2 to %f0\n";
    		template += indentString() + "fsubs\t%f1, %f2, %f0\n";
    		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
    		flush(template);
        }
        //Float add float
    	  else{
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! adding %f1 & %f2 to %f0\n";
    		template += indentString() + "fsubs\t%f1, %f2, %f0\n";
    		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
    		flush(template);
        }
    }
    //1.2 mul
    public void writeMulOp(int offset, STO a, STO b, int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	        if(a.isVar())
	          writeDoDesID(a);
	        else if (a.isConst())
	      	  flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0\n");
	        else if(a.isExpr())
	      	  writeDoDesID(a);
	        
	        String template = "! mulOP first operand:" + a.getName() + " to %o0\n";
	        template += indentString() + "mov\t%l0, %o0\n\n";
	        flush(template);
	        
	        if(b.isVar())
	          writeDoDesID(b);
	        else if (b.isConst())
	      	  flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0\n");
	        else if(b.isExpr())
	      	  writeDoDesID(b);
	        template = "! mulOP second operand:" + b.getName() + " to %o1\n";
	        template += indentString() + "mov\t%l0, %o1\n\n";
	        flush(template);
	        //Do the addop part
	        template += indentString() + "call\t.mul\n";
	        template += indentString() + "nop\n";
	        template += indentString() + "st\t%o0, [%fp" + "-" + offset + "]\n";
	        flush(template);
    	}
    	//If one of the operand is float
    	else if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
    		int position_to_store_tmp = offset - 4;
    		getValueIntof1(a, globalCounter, position_to_store_tmp);
    		getValueIntof2(b, globalCounter, position_to_store_tmp);
    		String template = "! adding %f1 & %f2 to %f0\n";
    		template += indentString() + "fmuls\t%f1, %f2, %f0\n";
    		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
    		flush(template);
        }
        //Float add float
    	  else{
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! adding %f1 & %f2 to %f0\n";
    		template += indentString() + "fmuls\t%f1, %f2, %f0\n";
    		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
    		flush(template);
        }
    }
    
    //1.2 div
    public void writeDivOp(int offset, STO a, STO b, int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	        if(a.isVar())
	          writeDoDesID(a);
	        else if (a.isConst())
	      	  flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0\n");
	        else if(a.isExpr())
	      	  writeDoDesID(a);
	        
	        String template = "! divOP first operand:" + a.getName() + " to %o0\n";
	        template += indentString() + "mov\t%l0, %o0\n\n";
	        flush(template);
	        
	        if(b.isVar())
	          writeDoDesID(b);
	        else if (b.isConst())
	      	  flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0\n");
	        else if(b.isExpr())
	      	  writeDoDesID(b);
	        template = "! divOP second operand:" + b.getName() + " to %o1\n";
	        template += indentString() + "mov\t%l0, %o1\n\n";
	        flush(template);
	        //Do the addop part
	        template += indentString() + "call\t.div\n";
	        template += indentString() + "nop\n";
	        template += indentString() + "st\t%o0, [%fp" + "-" + offset + "]\n";
	        flush(template);
    	}
    	//If one of the operand is float
    	else if((a.getType().isInt() && b.getType().isFloat()) || (a.getType().isFloat() && b.getType().isInt())){
    		int position_to_store_tmp = offset - 4;
    		getValueIntof1(a, globalCounter, position_to_store_tmp);
    		getValueIntof2(b, globalCounter, position_to_store_tmp);
    		String template = "! adding %f1 & %f2 to %f0\n";
    		template += indentString() + "fdivs\t%f1, %f2, %f0\n";
    		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
    		flush(template);
        }
        //Float add float
    	  else{
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! adding %f1 & %f2 to %f0\n";
    		template += indentString() + "fdivs\t%f1, %f2, %f0\n";
    		template += indentString() + "st\t%f0, [%fp" + "-" + offset + "]\n";
    		flush(template);
        }
    }
    public void writeModOp(int offset, STO a, STO b){   	
	  if(a.isVar())
	    writeDoDesID(a);
	  else if (a.isConst())
	    flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0");
	  else if(a.isExpr())
	    writeDoDesID(a);
	        
	  String template = "! modOP first operand:" + a.getName() + " to %o0\n";
	  template += indentString() + "mov\t%l0, %o0\n\n";
	  flush(template);
	        
	  if(b.isVar())
	    writeDoDesID(b);
	  else if (b.isConst())
	    flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0");
	  else if(b.isExpr())
	    writeDoDesID(b);
	  template = "! modOP second operand:" + b.getName() + " to %o1\n";
	  template += indentString() + "mov\t%l0, %o1\n\n";
	  flush(template);
	  //Do the addop part
	  template += indentString() + "call\t.rem\n";
	  template += indentString() + "nop\n";
	  template += indentString() + "st\t%o0, [%fp" + "-" + offset + "]\n";
	  flush(template);
    }
    
    public void writeBwAndOp(int offset, STO a, STO b){
    	if (a.isConst())
    	    flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0");
    	else
    	    writeDoDesID(a);
    	
    	String template = "! BwAndOP first operand:" + a.getName() + " to %l1\n";
   	  	template += indentString() + "mov\t%l0, %l1\n\n";
   	  	flush(template);
    	
    	
    	if (b.isConst())
    	    flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0");
    	else
    	    writeDoDesID(b);
    	
    	template = "! BwAndOP second operand:" + b.getName() + " to %l2\n";
   	  	template += indentString() + "mov\t%l0, %l2\n\n";
   	  	flush(template);
    	
   	  	//Do the BwAndOp part
        template = indentString() + "and\t%l1, %l2, %l0\n";
        template += indentString() + "st\t%l0, [%fp" + "-" + offset + "]\n";
        flush(template);
    }
    public void writeBwOrOp(int offset, STO a, STO b){
    	if (a.isConst())
    	    flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0");
    	else
    	    writeDoDesID(a);
    	
    	String template = "! BwOrOP first operand:" + a.getName() + " to %l1\n";
   	  	template += indentString() + "mov\t%l0, %l1\n\n";
   	  	flush(template);
    	
    	
    	if (b.isConst())
    	    flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0");
    	else
    	    writeDoDesID(b);
    	
    	template = "! BwOrOP second operand:" + b.getName() + " to %l2\n";
   	  	template += indentString() + "mov\t%l0, %l2\n\n";
   	  	flush(template);
    	
   	  	//Do the BwAndOp part
        template = indentString() + "or\t%l1, %l2, %l0\n";
        template += indentString() + "st\t%l0, [%fp" + "-" + offset + "]\n";
        flush(template);
    }
    public void writeBwXorOp(int offset, STO a, STO b){
    	if (a.isConst())
    	    flush(indentString() + "set\t" + ((ConstSTO)a).getIntValue() + ", %l0");
    	else
    	    writeDoDesID(a);
    	
    	String template = "! BwXorOP first operand:" + a.getName() + " to %l1\n";
   	  	template += indentString() + "mov\t%l0, %l1\n\n";
   	  	flush(template);
    	
    	
    	if (b.isConst())
    	    flush(indentString() + "set\t" + ((ConstSTO)b).getIntValue() + ", %l0");
    	else
    	    writeDoDesID(b);
    	
    	template = "! BwXorOP second operand:" + b.getName() + " to %l2\n";
   	  	template += indentString() + "mov\t%l0, %l2\n\n";
   	  	flush(template);
    	
   	  	//Do the BwXorOp part
        template = indentString() + "xor\t%l1, %l2, %l0\n";
        template += indentString() + "st\t%l0, [%fp" + "-" + offset + "]\n";
        flush(template);
    }
    
    public void writeGreaterThanOp(int offset, STO a, STO b, int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	    	if (a.isConst())
	            setConst("greatThanConstEval", (ConstSTO)a, globalCounter);
	    	else
	    	    writeDoDesID(a);
	    	
	    	String template = "! GreaterThanOP first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	   	  	flush(template);
	    	
	    	
	    	if (b.isConst())
	            setConst("greatThanConstEval", (ConstSTO)b, globalCounter);
	    	else
	    	    writeDoDesID(b);
	    	template = "! GreaterThanOP second operand:" + b.getName() + " to %l2\n";
	   	  	template += indentString() + "mov\t%l0, %l2\n\n";
	   	  	flush(template);
	   	  	
	   	  	template = indentString() + "cmp\t%l1, %l2\n";
	   	  	String label = "greaterThan" + globalCounter;
	   	  	template += indentString() + "bg\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! greatThanOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! greatThanOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
    	}
    	//If one of the operand is float
    	else{ 		
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! cmp %f1 & %f2\n";
    		template += indentString() + "fcmps\t%f1, %f2\n";
    		template += indentString() + "nop\n";
    		
    		
    		String label = "greaterThan" + globalCounter;
	   	  	template += indentString() + "fbg\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! greatThanOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! greatThanOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
        }
    }
    
    
    /*
     * This function is used to do greaterequalthan operation
     * Added by Mingshan
     */
    public void writeGreaterAndEqualThanOp(int offset,STO a,STO b,int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	        if(a.isConst()){
	          setConst("greatAndEqualThanConstEval", (ConstSTO)a, globalCounter);
	        }
	        else
	            writeDoDesID(a);
	        String template = "! GreaterThanEqualOp first operand : "+ a.getName() + "to %l1\n";
	        template += indentString() + "mov\t%l0,%l1\n\n";
	        flush(template);
	
	        if(b.isConst())
	        	setConst("greatAndEqualThanConstEval", (ConstSTO)b, globalCounter);
	        else
	            writeDoDesID(b);
	        template = "! GraterThanEqualOp second operand: " + b.getName() + " to %l2\n";
	        template += indentString() + "mov\t%l0,%l2\n\n";
	        flush(template);
	
	        template = indentString() + "cmp\t%l1,%l2\n";
	        String label = "greaterThanEqual" + globalCounter;
	        template += indentString() + "bge\t" + label + "\n";
	        template += indentString() + "nop\n\n";
	        //If strictly less than, than store the false value to the tmp
	        template += "! greaterThanEqualOp set falst\n";
	        template += indentString() + "mov\t%g0,%l0\n";
	        template += indentString() + "st\t%l0,[%fp-" + offset + "]\n";
	        template += indentString() + "ba\t" + label + "_done\n";
	        template += indentString() + "nop\n\n";
	
	        //If greaterequal than store true value to the tmp
	        template += label + ":\t\n";
	        template += "! greaterThanEqualThan set true\n";
	        template += indentString() + "set\t1,%l0\n";
	        template += indentString() + "st\t%l0,[%fp-" + offset + "]\n";
	        template += label + "_done:\n\n";
	        flush(template);
    	}
    	else{
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! cmp %f1 & %f2\n";
    		template += indentString() + "fcmps\t%f1, %f2\n";
    		template += indentString() + "nop\n";
    		
    		
    		String label = "greaterThanEqualThan" + globalCounter;
	   	  	template += indentString() + "fbge\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greaterThanEqual than, than store false value to the tmp
	   	  	template += "! greaterThanEqualThanOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greaterThanEqual than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! greaterThanEqualThanOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
    	}
    }

    public void writeLessThanOp(int offset, STO a, STO b, int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	    	if (a.isConst())
	            setConst("lessThanConstEval", (ConstSTO)a, globalCounter);
	    	else
	    	    writeDoDesID(a);
	    	
	    	String template = "! lessThanOP first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	   	  	flush(template);
	    	
	    	
	    	if (b.isConst())
	            setConst("lessThanConstEval", (ConstSTO)b, globalCounter);
	    	else
	    	    writeDoDesID(b);
	    	template = "! lessThanOP second operand:" + b.getName() + " to %l2\n";
	   	  	template += indentString() + "mov\t%l0, %l2\n\n";
	   	  	flush(template);
	   	  	
	   	  	template = indentString() + "cmp\t%l1, %l2\n";
	   	  	String label = "lessThan" + globalCounter;
	   	  	template += indentString() + "bl\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! lessThanOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! lessThanOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
    	}
    	//If one of the operand is float
    	else{ 		
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! cmp %f1 & %f2\n";
    		template += indentString() + "fcmps\t%f1, %f2\n";
    		template += indentString() + "nop\n";
    		
    		
    		String label = "lessThan" + globalCounter;
	   	  	template += indentString() + "fbl\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not less than, than store false value to the tmp
	   	  	template += "! lessThanOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If less than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! lessThanOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
        }
    }
    
    public void writeLessAndEqualThanOp(int offset, STO a, STO b, int globalCounter){
    	if(a.getType().isInt() && b.getType().isInt()){
	    	if (a.isConst())
	            setConst("lessAndEqualThanConstEval", (ConstSTO)a, globalCounter);
	    	else
	    	    writeDoDesID(a);
	    	
	    	String template = "! lessAndEqualThanOP first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	   	  	flush(template);
	    	
	    	
	    	if (b.isConst())
	            setConst("lessAndEqualThanConstEval", (ConstSTO)b, globalCounter);
	    	else
	    	    writeDoDesID(b);
	    	template = "! lessAndEqualThanOP second operand:" + b.getName() + " to %l2\n";
	   	  	template += indentString() + "mov\t%l0, %l2\n\n";
	   	  	flush(template);
	   	  	
	   	  	template = indentString() + "cmp\t%l1, %l2\n";
	   	  	String label = "lessAndEqualThan" + globalCounter;
	   	  	template += indentString() + "ble\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! lessAndEqualThanOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! lessAndEqualThanOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
    	}
    	//If one of the operand is float
    	else{ 		
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! cmp %f1 & %f2\n";
    		template += indentString() + "fcmps\t%f1, %f2\n";
    		template += indentString() + "nop\n";
    		
    		
    		String label = "lessAndEqualThan" + globalCounter;
	   	  	template += indentString() + "fble\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! lessAndEqualThanOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! lessAndEqualThanOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
        }
    }

    /*
     * This function is to deal with == binary expression
     */
    public void writeEqualOp(int offset, STO a, STO b, int globalCounter){
    	if((a.getType().isInt() && b.getType().isInt()) || (a.getType().isBool() && b.getType().isBool())){
	    	if (a.isConst())
	            setConst("equalConstEval", (ConstSTO)a, globalCounter);
	    	else
	    	    writeDoDesID(a);
	    	
	    	String template = "! equalOP first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	   	  	flush(template);
	    	
	    	
	    	if (b.isConst())
	            setConst("equalConstEval", (ConstSTO)b, globalCounter);
	    	else
	    	    writeDoDesID(b);
	    	template = "! EqualThanOP second operand:" + b.getName() + " to %l2\n";
	   	  	template += indentString() + "mov\t%l0, %l2\n\n";
	   	  	flush(template);
	   	  	
	   	  	template = indentString() + "cmp\t%l1, %l2\n";
	   	  	String label = "equalEqual" + globalCounter;
	   	  	template += indentString() + "be\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! equalOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! equalOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
    	}
    	//If one of the operand is float
    	else{ 		
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! cmp %f1 & %f2\n";
    		template += indentString() + "fcmps\t%f1, %f2\n";
    		template += indentString() + "nop\n";
    		
    		
    		String label = "equalEqual" + globalCounter;
	   	  	template += indentString() + "fbe\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! equalOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! equalOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
        }
    }
    
    /*
     * This function is to do != boolean expression
     */
    public void writeNotEqualOp(int offset, STO a, STO b, int globalCounter){
    	if((a.getType().isInt() && b.getType().isInt()) || (a.getType().isBool() && b.getType().isBool())){
	    	if (a.isConst())
	            setConst("notEqualConstEval", (ConstSTO)a, globalCounter);
	    	else
	    	    writeDoDesID(a);
	    	
	    	String template = "! notEqualOP first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	   	  	flush(template);
	    	
	    	
	    	if (b.isConst())
	            setConst("notEqualConstEval", (ConstSTO)b, globalCounter);
	    	else
	    	    writeDoDesID(b);
	    	template = "! notEqualOP second operand:" + b.getName() + " to %l2\n";
	   	  	template += indentString() + "mov\t%l0, %l2\n\n";
	   	  	flush(template);
	   	  	
	   	  	template = indentString() + "cmp\t%l1, %l2\n";
	   	  	String label = "notEqualTo" + globalCounter;
	   	  	template += indentString() + "bne\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! notEqualOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! notEqualOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
    	}
    	//If one of the operand is float
    	else{ 		
    		getValueIntof1(a, globalCounter, offset);
    		getValueIntof2(b, globalCounter, offset);
    		String template = "! cmp %f1 & %f2\n";
    		template += indentString() + "fcmps\t%f1, %f2\n";
    		template += indentString() + "nop\n";
    		
    		
    		String label = "notEqualTo" + globalCounter;
	   	  	template += indentString() + "fbne\t" + label + "\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If not greater than, than store false value to the tmp
	   	  	template += "! notEqualOp set false\n";
	   	  	template += indentString() + "set\t0, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += indentString() + "ba\t" + label + "_done\n";
	   	  	template += indentString() + "nop\n\n";
	   	  	//If greater than store true value to the tmp
	   	  	template += label + ":\t\n";
	   	  	template += "! notEqualOp set true\n";
	   	  	template += indentString() + "set\t1, %l0\n";
	   	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	   	  	template += label+"_done:\n\n";
	   	  	flush(template);
        }
    }
    
    /**
     * This method is for generating code to check && operator
     * Short circuiting if a evaluates to false.
     * @param offset
     * @param a
     * @param b
     * @param globalCounter
     */
    public void writeAndOp(int offset, STO a, STO b, int globalCounter, String label){
    	String template = "";
   	  	//Here if a is true, evaluate b
   	  	
    	if (b.isConst())
            setConst("AndConstEval", (ConstSTO)b, globalCounter);
    	else
    	    writeDoDesID(b);
    	template = "! AndOp second operand:" + a.getName() + " to %l1\n";
    	template += indentString() + "mov\t%l1, %l2\n\n";
    	flush(template);
    	
    	template = "! Comparing %l2 with %g0\n";
   	  	template += indentString() + "cmp\t%l0, %g0\n";
   	  	//If it's false, go to end
   	  	template += indentString() + "be\t" + label + "\n";
   	  	template += indentString() + "nop\n";
   	  	flush(template);
   	  	//Here if both are true
   	  	template = "! it enter here if both side are true\n";
   	  	//Set to true
   	  	template += indentString() + "set\t1, %l0\n";
	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	  	template += indentString() + "ba\tAddOp_End" + globalCounter + "\n";
	  	template += indentString() + "nop\n";
	  	
	  	//Set false label
	  	template += label + ": \n";
	  	template += indentString() + "set\t0, %l0\n";
	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	  	template += "AddOp_End" + globalCounter + ": \n";
	  	flush(template);
    }
    
    /**
     * This method is for generating code to check && operator
     * Short circuiting if a evaluates to true.
     * @param offset
     * @param a
     * @param b
     * @param globalCounter
     */
    public void writeOrOp(int offset, STO a, STO b, int globalCounter, String label){
    	String template = "";
   	  	//Here if a is true, evaluate b
   	  	
    	if (b.isConst())
            setConst("OrConstEval", (ConstSTO)b, globalCounter);
    	else
    	    writeDoDesID(b);
    	template = "! OrOp second operand:" + a.getName() + " to %l2\n";
    	template += indentString() + "mov\t%l0, %l2\n\n";
    	flush(template);
    	
    	template = "! Comparing %l2 with %g0\n";
   	  	template += indentString() + "cmp\t%l2, %g0\n";
   	  	//If it's true, go to end
   	  	template += indentString() + "bne\t" + label + "\n";
   	  	template += indentString() + "nop\n";
   	  	flush(template);
   	  	//Here if both are false
   	  	template = "! it enter here if both side are false\n";
   	  	//Set to true
   	  	template += indentString() + "set\t0, %l0\n";
	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	  	template += indentString() + "ba\tOrOp_End" + globalCounter + "\n";
	  	template += indentString() + "nop\n";
	  	
	  	//Set false label
	  	template += label + ": \n";
	  	template += indentString() + "set\t1, %l0\n";
	  	template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
	  	template += "OrOp_End" + globalCounter + ": \n";
	  	flush(template);
    }
    
    public void writeOrOpFirst(int offset, STO a, String label, int globalCounter){
    	if (a.isConst())
            setConst("OrConstEval", (ConstSTO)a, globalCounter);
    	else
    	    writeDoDesID(a);
    	
    	String template = "! OrOp first operand:" + a.getName() + " to %l1\n";
    	template += indentString() + "mov\t%l0, %l1\n\n";
   	  	flush(template);
    	
   	  	template = "! Comparing %l1 with %g0\n";
   	  	template += indentString() + "cmp\t%l1, %g0\n";
   	  	//If it's false, go to end
   	  	template += indentString() + "bne\t" + label + "\n";
   	  	template += indentString() + "nop\n";
   	  	flush(template);
    }
    
    public void writeAndOpFirst(int offset, STO a, String label, int globalCounter){
    	if (a.isConst())
            setConst("AndConstEval", (ConstSTO)a, globalCounter);
    	else
    	    writeDoDesID(a);
    	
    	String template = "! AndOp first operand:" + a.getName() + " to %l1\n";
    	template += indentString() + "mov\t%l0, %l1\n\n";
   	  	flush(template);
    	
   	  	template = "! Comparing %l1 with %g0\n";
   	  	template += indentString() + "cmp\t%l1, %g0\n";
   	  	//If it's false, go to end
   	  	template += indentString() + "be\t" + label + "\n";
   	  	template += indentString() + "nop\n";
   	  	flush(template);
    }
    
    public void writeCinInt(STO s){
    	String template = "! Doing CIN Int statement\n";
    	template += indentString() + "set\t" + s.getOffset() + ", %l0\n";
    	template += indentString() + "add\t" + s.getBase() + ", %l0, %l0\n";
    	template += indentString() + "call\tinputInt\n";
    	template += indentString() + "nop\n";
    	template += indentString() + "st\t%o0, [%l0]\n";
    	flush(template);
    }
    
    public void writeCinFloat(STO s){
    	String template = "! Doing CIN Float statement\n";
    	template += indentString() + "set\t" + s.getOffset() + ", %l0\n";
    	template += indentString() + "add\t" + s.getBase() + ", %l0, %l0\n";
    	template += indentString() + "call\tinputFloat\n";
    	template += indentString() + "nop\n";
    	template += indentString() + "st\t%f0, [%l0]\n";
    	flush(template);
    }

    /**
     * 2.2 While statement
     * @param label
     */
    public void writeWhileLabel(String label, String endLabel){
    	String template = "! Do While Label\n";
    	template += label + ": \n";
    	flush(template);
    }
    public void writeWhileCheckCondition(String endLabel){
    	String template = "";
    	template += indentString() + "cmp\t%l0, %g0\n";
    	//If it's false, need to go to end of while
    	template += indentString() + "be\t" + endLabel + "\n";
    	template += indentString() + "nop\n";
    	flush(template);
    }
    public void writeWhileLoopCheck(String label, String endLabel){
    	String template = "! while loop ending always go back\n";
    	template += indentString() + "ba\t" + label + "\n";
		template += indentString() + "nop\n";
		template += endLabel + ": \n";
		flush(template);
    }
    
    public void writeBreakStmt(String endLabel){
    	String template = "! break stmt\n";
    	template += indentString() + "ba\t" + endLabel + "\n";
    	template += indentString() + "nop\n";
    	flush(template);
    }
    
    public void writeContinueStmt(String label){
    	String template = "! continue stmt\n";
    	template += indentString() + "ba\t" + label + "\n";
    	template += indentString() + "nop\n";
    	flush(template);
    }
    /**
     * This method assumes that decrement or increment has been done and the value is in %l1
     * And if it's a float, it will assume the value has been set into %f0
     * @param sto
     */
    public void storeValueBack(STO sto){
    	String template = "";
    	if(sto.getType().isInt()){
	    	template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
	        template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
		    template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";	
		    flush (template);
		}
    	else if(sto.getType().isFloat()){
    		template += indentString() + "set\t" + sto.getOffset() + ", " + "%l0\n";
	        template += indentString() + "add\t" + sto.getBase() + ", %l0, %l0\n";
		    template += indentString() + "st\t" + "%f0, " + "[%l0]\n\n";	
		    flush (template);
    		
    	}
    }
    /* 1.3 */
    public void writePreIncOp(String offset, STO a){
    	//a must be a mod l-val
    	writeDoDesID(a);
    	if(a.getType().isInt()){
	    	String template = "! PreIncOp first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	   	  	template += indentString() + "inc\t%l1\n\n";
	   	  	template += "! Store the pre inc value into local tmp\n";
	   	  	template += indentString() + "st\t%l1, [%fp" + offset + "]\n";
	   	  	flush(template);
	   	  	storeValueBack(a);
    	}
    	else if(a.getType().isFloat()){
    		String template = "! PreIncOp float first operand: " + a.getName() + " to %f0\n";
    		template += indentString() + "set\tvalue_one, %l0\n";
    		template += indentString() + "ld\t[%l0], %f1\n";
    		template += indentString() + "fadds\t%f0, %f1, %f0\n";
    		template += "! Store the pre inc value into local tmp\n";
	   	  	template += indentString() + "st\t%f0, [%fp" + offset + "]\n";
    		flush(template);
	   	  	storeValueBack(a);
    	}
    }
    public void writePreDecOp(String offset, STO a){
    	//a must be a mod l-val
    	writeDoDesID(a);
    	if(a.getType().isInt()){
	    	String template = "! PreDecOp first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	   	  	template += indentString() + "dec\t%l1\n\n";
	   	  	template += "! Store the pre dec value into local tmp\n";
	   	  	template += indentString() + "st\t%l1, [%fp" + offset + "]\n";
	   	  	flush(template);
	   	  	storeValueBack(a);
    	}
    	else if(a.getType().isFloat()){
    		String template = "! PreDecOp float first operand: " + a.getName() + " to %f0\n";
    		template += indentString() + "set\tvalue_one, %l0\n";
    		template += indentString() + "ld\t[%l0], %f1\n";
    		template += indentString() + "fsubs\t%f0, %f1, %f0\n";
    		template += "! Store the pre inc value into local tmp\n";
	   	  	template += indentString() + "st\t%f0, [%fp" + offset + "]\n";
    		flush(template);
	   	  	storeValueBack(a);
    	}
    }
    
    public void writePostIncOp(String offset, STO a){
    	writeDoDesID(a);
    	if(a.getType().isInt()){
	    	String template = "! PostIncOp first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	    	
	    	template += "! Store the previous value before post inc to a tmp location\n";
	    	template += indentString() + "set\t" + offset + ", " + "%l0\n";
	        template += indentString() + "add\t%fp, %l0, %l0\n";
		    template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";	
		    
	   	  	template += indentString() + "inc\t%l1\n\n";
	   	  	flush(template);
	   	  	storeValueBack(a);
    	}
    	else if(a.getType().isFloat()){
    		String template = "! PostIncOp float first operand: " + a.getName() + " to %f0\n";
    		template += "! Store the value of %f0 to a tmp location\n";
    		template += indentString() + "set\t" + offset + ", " + "%l0\n";
    		template += indentString() + "add\t%fp, %l0, %l0\n";
    		template += indentString() + "st\t" + "%f0, " + "[%l0]\n\n";	
    		template += indentString() + "set\tvalue_one, %l0\n";
    		template += indentString() + "ld\t[%l0], %f1\n";
    		template += indentString() + "fadds\t%f0, %f1, %f0\n";
    		flush(template);
	   	  	storeValueBack(a);
    	}
    }
    
    public void writePostDecOp(String offset, STO a){
    	writeDoDesID(a);
    	if(a.getType().isInt()){
	    	String template = "! PostDecOp first operand:" + a.getName() + " to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n\n";
	    	
	    	template += "! Store the previous value before post inc to a tmp location\n";
	    	template += indentString() + "set\t" + offset + ", " + "%l0\n";
	        template += indentString() + "add\t%fp, %l0, %l0\n";
		    template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";	
		    
	   	  	template += indentString() + "dec\t%l1\n\n";
	   	  	flush(template);
	   	  	storeValueBack(a);
    	}
    	else if(a.getType().isFloat()){
    		String template = "! PostDecOp float first operand: " + a.getName() + " to %f0\n";
    		template += "! Store the value of %f0 to a tmp location\n";
    		template += indentString() + "set\t" + offset + ", " + "%l0\n";
    		template += indentString() + "add\t%fp, %l0, %l0\n";
    		template += indentString() + "st\t" + "%f0, " + "[%l0]\n\n";	
    		template += indentString() + "set\tvalue_one, %l0\n";
    		template += indentString() + "ld\t[%l0], %f1\n";
    		template += indentString() + "fsubs\t%f0, %f1, %f0\n";
    		flush(template);
	   	  	storeValueBack(a);
    	}
    }
    
    /**
     * 2.1 Not op
     * @param offset
     * @param a
     */
    public void writeNotOp(String offset, STO a, int globalCounter){
    	writeDoDesID(a);
    	String template = "! NotOp first operand:" + a.getName() + " to %l1\n";
    	template += indentString() + "mov\t%l0, %l1\n\n";
    	template += indentString() + "cmp\t%l1, %g0\n";
    	template += indentString() + "be\tNotOpSetZero" + globalCounter + "\n";
    	template += indentString() + "nop\n";
    	//it's true need to set false
    	template += "! the value is true, need to set to false\n";
    	template += indentString() + "mov\t%g0, %l1\n";
    	template += indentString() + "set\t" + offset + ", " + "%l0\n";
        template += indentString() + "add\t%fp, %l0, %l0\n";
	    template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";
	    template += indentString() + "ba\tendOfNotOp" + globalCounter +"\n";
	    template += indentString() + "nop\n";
    	//If it's false, need to set true
    	template += "! the value is false, need to set to true\n";
    	template += "NotOpSetZero" + globalCounter + ": \n";
    	template += indentString() + "set\t1, %l1\n";
    	template += indentString() + "set\t" + offset + ", " + "%l0\n";
        template += indentString() + "add\t%fp, %l0, %l0\n";
	    template += indentString() + "st\t" + "%l1, " + "[%l0]\n\n";
	    
	    template += "endOfNotOp" + globalCounter + ": \n";
   	  	flush(template);
    }
    
    /**
     * 1.3 Exit statement
     */
    public void writeExit(STO expr, int globalCounter){
    	flush("\n! set exit statement number to %o0\n");
    	if(expr.isConst())
    		setConst("exitStmtNumber", (ConstSTO)expr, globalCounter);
    	else
    		writeDoDesID(expr);
    	String template = indentString() + "mov\t%l0, %o0\n";
    	template += indentString() + "call\texit\n";
    	template += indentString() + "nop\n";
    	flush(template);
    }
    
    /**
     * This method is for write code to do assignment
     * @param left
     * @param right
     */
    public void writeAssignment(STO left, STO right, int globalCounter, int offset){
    	String template = "";
    	flush("! Doing Assignment, getting the right side value\n");
    	if(right.isConst()){
    		setConst(left.getName() + "_assign_right", (ConstSTO)right, globalCounter);
    	}
    	else{
    		writeDoDesID(right);
    		if(right.getType().isReference()){
    			template += "! Doing assignment, Reference variable, need to load one more time\n";
	    		template += indentString() + "ld\t[%l0], %l0\n";
	    		flush(template);
    		}
    	}
    	//Check if need promption
    	if(left.getType().isFloat() && right.getType().isInt()){
    		template += "! prompt int to float\n";
    		template += indentString() + "st\t%l0, [%fp-" + offset + "]\n";
    		template += indentString() + "ld\t[%fp-" + offset + "], %f0\n";
    		//Prompt an int to float
    		template += indentString() + "fitos\t %f0, %f0\n";
    		if(left.getName().equals("array_doDesignator2")){
    			template += indentString() + "mov\t%l2, %l0\n";
    		}
    		else{
    			template += indentString() + "set\t" + left.getOffset() + ", " + "%l0\n";
    			template += indentString() + "add\t" + left.getBase() + ", %l0, %l0\n";
    		}
	    	template += indentString() + "st\t%f0, [%l0]\n\n";
    	}else{
	    	template += "! moving the right side value to %l1\n";
	    	template += indentString() + "mov\t%l0, %l1\n";
	    	template += "! Doing Assignment, getting the left side location\n";
	    	if(left.getName().equals("array_doDesignator2")){
	    		template += indentString() + "mov\t%l2, %l0\n";
	    	}
	    	else{
	    		template += indentString() + "set\t" + left.getOffset() + ", " + "%l0\n";
	    		template += indentString() + "add\t" + left.getBase() + ", %l0, %l0\n";
	    	}
			if(left.getType().isReference()){
				template += "! reference type left, need to load one more time to store\n";
				template += indentString() + "ld\t[%l0], %l0\n";
			}
	    	template += indentString() + "st\t%l1, [%l0]\n";
    	}
    	flush(template);
    }
    
    /**
     * This method is for cmp the expr inside if statement
     * @param s
     * @param label
     */   
    public void writeIfStart(STO s, String label){
      String template = "";
      if(s.isConst()){
    	template += indentString() + "set\t" + ((ConstSTO)s).getIntValue() + ", %l0\n";
    	flush(template);
      }
      else{
    	writeDoDesID(s);
      }
      template = indentString() + "cmp\t%l0, 0\n";
      //If it's false, go to label (end of if statement)
      //TODO, may need to go to else statement
      template += indentString() + "be\t" + label + "\n";
      template += indentString() + "nop\n";
      flush(template);
    }
    
    public void writeIfEnd(String label){
      String template = "";
      //When the yes branch of if ended, always go to the end of the whole if-else statement
      template += indentString() + "ba\t" + label + "\n";
      template += indentString() + "nop\n";
      flush(template);
    }
    
    /**
     * This method is for when the whole if else statement ended, write an end label
     * @param label
     */
    public void writeIfCompleteEnd(String label){
      String template = "";
      template += label + ": \n\n";
      flush(template);
    }
    
    public void writeDecltype(int globalCounter){
      String template = indentString() + "ba\tdecltype_" + globalCounter + "\n";
      template += indentString() + "nop\n";
      flush(template);
    }
    
    public void writeDecltypeDone(int count){
      String template = "decltype_" + count + ": \n";
      flush(template);
    }
    
    /**
     * 
     * @param arrayName
     * @param indexExpr
     */
    public void writeDoArrayDes(STO arrayName, STO indexExpr){
    	flush("! doing array dereference\n");
    	//Move the index value into %l0
    	if(indexExpr.isConst()){
    		flush(indentString() + "set\t" + ((ConstSTO)indexExpr).getIntValue() + ", %l0\n");
    	}
    	else
    		writeDoDesID(indexExpr);
    	//Store index value to %l1
    	String template = "";
    	template += indentString() + "set\t" + ((CompositeType)arrayName.getType()).getElementType().getSize() + ", %o0\n";
    	template += indentString() + "mov\t%l0, %o1\n";
    	template += indentString() + "call\t.mul\n";
    	template += indentString() + "nop\n\n";
    	//Move the actual offset to %l1
    	template += "! the actual offset in %o0\n";
    	template += indentString() + "set\t" + arrayName.getOffset() + ", " + "%l0\n";
		template += indentString() + "add\t" + arrayName.getBase() + ", %l0, %l0\n";
    	template += indentString() + "add\t%l0, %o0, %l0\n";
    	if(((ArrayType)(arrayName.getType())).getElementType().isFloat()){
    		template += indentString() + "ld\t[%l0], %f0\n";
    	}
    	template += indentString() + "mov\t%l0, %l2\n";
    	template += indentString() + "ld\t[%l0], %l0\n";
    	template += "! done with do array des\n";
    	flush(template);
    }
    
    
    // 9
    public void writeAssembly(String template, String ... params) {
        StringBuilder asStmt = new StringBuilder();
        
        // 10
        for (int i=0; i < indent_level; i++) {
            asStmt.append(SEPARATOR);
        }
        
        // 11
        asStmt.append(String.format(template, (Object[])params));
        
        try {
            fileWriter.write(asStmt.toString());
        } catch (IOException e) {
            System.err.println(ERROR_IO_WRITE);
            e.printStackTrace();
        }
    }
    
    // 12
    /*
    public static void main(String args[]) {
        AssemblyCodeGenerator myAsWriter = new AssemblyCodeGenerator("output.s");

        myAsWriter.increaseIndent();
        myAsWriter.writeAssembly(TWO_PARAM, SET_OP, String.valueOf(4095), "%l1");
        myAsWriter.increaseIndent();
        myAsWriter.writeAssembly(TWO_PARAM, SET_OP, String.valueOf(1024), "%l1");
        myAsWriter.decreaseIndent();
        
        myAsWriter.writeAssembly(TWO_PARAM, SET_OP, String.valueOf(512), "%l2");
        
        myAsWriter.decreaseIndent();
        myAsWriter.dispose();
    }
    */
}

