public class NullAndVoidClass {
	String Name;
    
 	public NullAndVoidClass(String arg){
        this.Name = Method1(arg);
    }
    
    public NullAndVoidClass(){
        this.Name = Method1('FirstCall');
    }
    public String Method1(String arg){
        String str = 'Method1';
        if(arg == null){
        	    this.Name = str;
        }
        else{
            	this.Name = arg;
        }
        
        return arg;
    }
}