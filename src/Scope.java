//---------------------------------------------------------------------
//
//---------------------------------------------------------------------

import java.util.Vector;


class Scope
{
	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public 
	Scope ()
	{
		m_lstLocals = new Vector<STO> ();
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public STO
	access (String strName)
	{
		return	accessLocal (strName);
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public STO
	accessLocal (String strName)
	{
		STO		sto = null;

		for (int i = 0; i < m_lstLocals.size (); i++)
		{
			sto = m_lstLocals.elementAt (i);

			if (sto.getName ().equals (strName))
				return (sto);
		}

		return (null);
	}


	//----------------------------------------------------------------
	//
	//----------------------------------------------------------------
	public void
	InsertLocal (STO sto)
	{
		m_lstLocals.addElement (sto);
	}

	/**
	 * This is for struct, return the declared STO to fill the struct fields
	 * @return
	 */
	public Vector<STO> getLocals(){
		return this.m_lstLocals;
	}

//----------------------------------------------------------------
//	Instance variables.
//----------------------------------------------------------------
	private Vector<STO>		m_lstLocals;
}
