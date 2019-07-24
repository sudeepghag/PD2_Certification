global class FirstBacheableClass implements Database.Batchable<sObject>, Schedulable{

 global String query;
    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        query = 'Select Id, Subject, ContactId from Case where Status = \'New\''; 
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.batchableContext bc, List<SObject> scope){
	
        try{
           
			List<Messaging.SingleEmailMessage> allEmails = new List<Messaging.SingleEmailMessage>();
            
            for(sObject s : scope){ 
            
                    Case objCase = (Case) s;
                	Id templateId = '00Xf20000057VcQ';
                	Id orgWideEmailAddressId = '0D2f2000000blve';
                	Boolean saveAsActivity = true;
					
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    
                    mail.setTargetObjectId(objCase.ContactId);
                    mail.setWhatId(objCase.id);
                    mail.setTemplateId(templateId);//'00Xf2000005fbIM');   //Support:Case Updates
                    mail.setOrgWideEmailAddressId(orgWideEmailAddressId);//'0D2f20000008Tob');    //Support Team
                    mail.setSaveAsActivity(saveAsActivity);//true	
					allEmails.add(mail);		
           }//for 

			Messaging.Email[] allMails = new list<Messaging.Email>();

			for( Integer j = 0; j < allEmails.size(); j++ ){
				allMails.add(allEmails.get(j));
			}//for	

			Messaging.SendEmailResult[] results = Messaging.sendEmail( allMails );


            System.debug('LIMIT --> Limits.getLimitEmailInvocations(): ' + Limits.getLimitEmailInvocations());
            System.debug('USED --> Limits.getEmailInvocations(): ' + Limits.getEmailInvocations());
            
            
			String emailErrorReport ='';
            Messaging.SendEmailError[] errors = new Messaging.SendEmailError[]{};
			for( Messaging.SendEmailResult currentResult : results ) {
				errors = currentResult.getErrors();
				if( null != errors ) {
					for( Messaging.SendEmailError currentError : errors ) {
						emailErrorReport = emailErrorReport + '(' + currentError.getStatusCode() + ') ' + currentError.getMessage() + '\r' ;
					}//for
				}//if
			}//for
			
			system.debug('emailErrorReport: ' + emailErrorReport);			
			
					
		   
		}//try
        catch(Exception e){
            //SFDebugHelper.debug(bc.getJobId(), 'Bacheable.execute.Exception = ' + e.getCause() + ' # Message = ' + e.getMessage() + ' # Stack: ' + e.getStackTraceString());
        }
    }//execute
    
    global void finish(Database.BatchableContext bc){
        //SFDebugHelper.debug(bc.getJobId(), 'Bacheable.finish' );
    }
    
    global void execute(SchedulableContext sc){
        //SFDebugHelper.debug( sc.getTriggerId(), 'Bacheable.execute.SchedulableContext' );	
        FirstBacheableClass instFirstBacheableClass = new FirstBacheableClass();
        database.executeBatch(instFirstBacheableClass,200);        
    }
    
}