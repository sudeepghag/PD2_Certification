@isTest
public class TestMeWell {
	
    @isTest public static void Method1(){
        String str = 'Method - 1';
     	system.debug('Method - 1'); 
        system.assertEquals(100, 50, 'Method-1: Assersion');
    }
    
    
    @isTest public static void Method2(){
     	String str = 'Method - 1';
        system.debug('Method - 2');
        system.assertEquals(100, 100, 'Method-2: Assersion');
    }
    
    @isTest public static void Method3(){
        String str = 'Method - 3';
     	system.debug('Method - 3'); 
        NullAndVoidClass nv = new NullAndVoidClass('abcdefghijklmnop');
    }
    
    
}