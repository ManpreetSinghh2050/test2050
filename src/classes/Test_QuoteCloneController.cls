/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Test_QuoteCloneController {

    static testMethod void myUnitTest() {
    	
    	 Account a = new Account(Name = 'Test Account');
        insert a;

        Opportunity o = new Opportunity(Name = 'Test Opp', StageName = 'Test Stage', CloseDate = Date.today(), AccountId = a.Id);
        insert o;

        Id pricebookId = Test.getStandardPricebookId();

        Product2 p = new Product2(Name = 'Test Product', isActive = true);
        insert p;

        PricebookEntry pbe = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = p.Id, UnitPrice = 1, isActive = true);
        insert pbe;

        Quote q = new Quote(Name = 'Test Quote', OpportunityId = o.Id, PriceBook2Id = pricebookId);
        insert q;

        QuoteLineItem qli = new QuoteLineItem(QuoteId = q.Id, PriceBookEntryId = pbe.Id, Quantity = 1, UnitPrice = 100);
        insert qli;
    	 ApexPages.StandardController sc = new ApexPages.StandardController(o);
    	 QuoteCloneController QuoteCloneCon=new QuoteCloneController(sc);
    	  PageReference pageRef = Page.QuoteClone;
          Test.setCurrentPage(pageRef);
          QuoteCloneCon.quotemap.put(q.id,q);
          QuoteCloneCon.quoteIdparam=q.id;
          Test.startTest();
          QuoteCloneCon.quoteCloning();
    	  Test.stopTest();
        // TO DO: implement unit test
        
    }
}