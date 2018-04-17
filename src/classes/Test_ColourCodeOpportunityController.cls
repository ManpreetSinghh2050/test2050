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
private class Test_ColourCodeOpportunityController {

    static testMethod void myUnitTest() {
    	
    	 List<Opportunity> oppList = new List<Opportunity>();
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'Test Opp1 Kovach';
        opp1.Amount = 100000.0;
        opp1.StageName = 'Active';
        opp1.CloseDate = System.today().addDays(10);
        opp1.Glass_Price__c = 60000.0;
        opp1.G_Est_Start_Date__c = System.Today().addDays(-5);
        opp1.G_Est_Completion_Date__c = System.Today().addDays(5);
        opp1.G_Est_Man_Hours_Shop__c = 10;
        opp1.G_Est_Man_Hours_Field__c = 5;
        opp1.G_Crew_Size__c = 20;
        opp1.Material_Cost__c = 5000.0;
        opp1.Shop_Labor_Cost__c = 2500.0;
        opp1.Field_Labor_Costs__c = 2000.0;
        opp1.Glass_GPM__c = 60;
        opp1.Glass_Lost__c = false;
        opp1.Metal_Price__c = 40000.0;
        opp1.M_Est_Start_Date__c = System.Today().addDays(-5);
        opp1.M_Est_Completion_Date__c = System.Today().addDays(5);
        opp1.M_Est_Man_Hours_Shop__c = 6;
        opp1.M_Est_Man_Hours_Field__c = 5;
        opp1.M_Crew_Size__c = 15;
        opp1.M_Material_Cost__c = 3500.0;
        opp1.M_Shop_Labor_Cost__c = 2000.0;
        opp1.M_Field_Labor_Cost__c = 1000.0;
        opp1.Metal_GPM__c = 40;
        opp1.Metal_Lost__c = false;
        opp1.Field_Completion_Date__c=system.today().addDays(5);
        oppList.add(opp1);
        
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'Test Opp2 Kovach';
        opp2.Amount = 100000.0;
        opp2.StageName = 'Active';
        opp2.CloseDate = System.today().addDays(10);
        opp2.Glass_Price__c = 60000.0;
        opp2.G_Est_Start_Date__c = System.Today().addDays(-5);
        opp2.G_Est_Completion_Date__c = System.Today().addDays(5);
        opp2.G_Est_Man_Hours_Shop__c = 10;
        opp2.G_Est_Man_Hours_Field__c = 5;
        opp2.G_Crew_Size__c = 20;
        opp2.Material_Cost__c = 5000.0;
        opp2.Shop_Labor_Cost__c = 2500.0;
        opp2.Field_Labor_Costs__c = 2000.0;
        opp2.Glass_GPM__c = 60;
        opp2.Glass_Lost__c = true;
        opp2.Metal_Price__c = 40000.0;
        opp2.M_Est_Start_Date__c = System.Today().addDays(-5);
        opp2.M_Est_Completion_Date__c = System.Today().addDays(5);
        opp2.M_Est_Man_Hours_Shop__c = 6;
        opp2.M_Est_Man_Hours_Field__c = 5;
        opp2.M_Crew_Size__c = 15;
        opp2.M_Material_Cost__c = 3500.0;
        opp2.M_Shop_Labor_Cost__c = 2000.0;
        opp2.M_Field_Labor_Cost__c = 1000.0;
        opp2.Metal_GPM__c = 40;
        opp2.Metal_Lost__c = true;
        oppList.add(opp2);
        
        Opportunity oppOnlyGlass = new Opportunity();
        oppOnlyGlass.Name = 'Test oppOnlyGlass Kovach';
        oppOnlyGlass.Amount = 100000.0;
        oppOnlyGlass.StageName = 'Active';
        oppOnlyGlass.CloseDate = System.today().addDays(10);
        oppOnlyGlass.Glass_Price__c = 60000.0;
        oppOnlyGlass.G_Est_Start_Date__c = System.Today().addDays(-5);
        oppOnlyGlass.G_Est_Completion_Date__c = System.Today().addDays(5);
        oppOnlyGlass.G_Est_Man_Hours_Shop__c = 10;
        oppOnlyGlass.G_Est_Man_Hours_Field__c = 5;
        oppOnlyGlass.G_Crew_Size__c = 20;
        oppOnlyGlass.Material_Cost__c = 5000.0;
        oppOnlyGlass.Shop_Labor_Cost__c = 2500.0;
        oppOnlyGlass.Field_Labor_Costs__c = 2000.0;
        oppOnlyGlass.Glass_GPM__c = 60;
       // oppOnlyGlass.Glass_Lost__c = true;
       // oppOnlyGlass.Metal_Price__c = 40000.0;
        //oppOnlyGlass.M_Est_Start_Date__c = System.Today().addDays(-5);
       // oppOnlyGlass.M_Est_Completion_Date__c = System.Today().addDays(5);
       // oppOnlyGlass.M_Est_Man_Hours_Shop__c = 6;
       // oppOnlyGlass.M_Est_Man_Hours_Field__c = 5;
        //oppOnlyGlass.M_Crew_Size__c = 15;
        //oppOnlyGlass.M_Material_Cost__c = 3500.0;
        //oppOnlyGlass.M_Shop_Labor_Cost__c = 2000.0;
       // oppOnlyGlass.M_Field_Labor_Cost__c = 1000.0;
        //oppOnlyGlass.Metal_GPM__c = 40;
        //oppOnlyGlass.Metal_Lost__c = true;
         oppOnlyGlass.Field_Completion_Date__c=system.today().addDays(5);
        oppList.add(oppOnlyGlass);
        
        Opportunity oppOnlyMetal = new Opportunity();
        oppOnlyMetal.Name = 'Test oppOnlyMetal Kovach';
        oppOnlyMetal.Amount = 100000.0;
        oppOnlyMetal.StageName = 'Active';
        oppOnlyMetal.CloseDate = System.today().addDays(10);
        oppOnlyMetal.Glass_Price__c = 60000.0;
        oppOnlyMetal.G_Est_Start_Date__c = System.Today().addDays(-5);
        oppOnlyMetal.G_Est_Completion_Date__c = System.Today().addDays(5);
        oppOnlyMetal.G_Est_Man_Hours_Shop__c = 10;
        oppOnlyMetal.G_Est_Man_Hours_Field__c = 5;
        oppOnlyMetal.G_Crew_Size__c = 20;
        oppOnlyMetal.Material_Cost__c = 5000.0;
        oppOnlyMetal.Shop_Labor_Cost__c = 2500.0;
        oppOnlyMetal.Field_Labor_Costs__c = 2000.0;
        oppOnlyMetal.Glass_GPM__c = 60;
        oppOnlyMetal.Glass_Lost__c = true;
       oppOnlyMetal.Metal_Price__c = 40000.0;
       oppOnlyMetal.M_Est_Start_Date__c = System.Today().addDays(-5);
       oppOnlyMetal.M_Est_Completion_Date__c = System.Today().addDays(5);
       oppOnlyMetal.M_Est_Man_Hours_Shop__c = 6;
       oppOnlyMetal.M_Est_Man_Hours_Field__c = 5;
       oppOnlyMetal.M_Crew_Size__c = 15;
       oppOnlyMetal.M_Material_Cost__c = 3500.0;
       oppOnlyMetal.M_Shop_Labor_Cost__c = 2000.0;
       oppOnlyMetal.M_Field_Labor_Cost__c = 1000.0;
       oppOnlyMetal.Metal_GPM__c = 40;
       //oppOnlyMetal.Metal_Lost__c = true;
         oppOnlyMetal.Field_Completion_Date__c=system.today().addDays(5);
        oppList.add(oppOnlyMetal);
    	insert oppList;
    	JsonParser jsonParserinstance=new JsonParser();
    	ColourCodeOpportunityController cCodeOpp=new ColourCodeOpportunityController();
    	cCodeOpp.filter='AZ';
    	cCodeOpp.getFilterOpportunity();
    	cCodeOpp.beginning();
    	cCodeOpp.next();
    	cCodeOpp.getDisableNext();
    	cCodeOpp.getDisablePrevious();
        // TO DO: implement unit test
        
    }
}