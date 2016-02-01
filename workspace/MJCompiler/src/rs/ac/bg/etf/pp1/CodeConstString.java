package rs.ac.bg.etf.pp1;
import rs.etf.pp1.mj.runtime.Code;

public class CodeConstString {
	private byte[] buf = new byte[2048];
	private final int buffsize = 2048;
	public int pc = 0;
	
	public void put (int x)  
	{
		if (pc < buffsize)
		{
			buf[pc++] = (byte)x;
		}
	}
	
	public void put2 (int x) { put(x>>8); put(x); }
	 
	public void put4 (int x) { put2(x>>16); put2(x); }

	public void loadConst (int n) 
	{
	    if (0 <= n && n <= 5) put(Code.const_n+n);
	    else if (n == -1) put(Code.const_m1);
	    else {put(Code.const_);put4(n);}
	}
	
	public int size() { return pc; }
	
	public byte [] getBuffer() { return buf; }
}
