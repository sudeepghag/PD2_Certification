trigger CaseTrigger on Case (before insert, after insert) {

    if(Trigger.isBefore && Trigger.isInsert){
    
        list<Case> listCases = new list<Case>{};
        
        for(Case c: Trigger.new){
            if(c.description == null || c.description==''){
               //c.description = '<NULL>'; 
            }
        }
    
        //update listCases;
    }

    if(Trigger.isAfter && Trigger.isInsert){
    
        list<Case> listCases = new list<Case>{};
        
        for(Case c: Trigger.new){
            if(c.description == null || c.description==''){               
               Case cNew = new Case(Id=c.Id, description='<NULL>');
               listCases.add(cNew);
            }
        }
    
        update listCases;
    }    
    
}