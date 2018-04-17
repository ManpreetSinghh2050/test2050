public class JsonParser{
		public tasks tasks{get;set;}
		public datatable datatable{get;set;}
		public processes processes{get;set;}
		public list<categories> categories{get;set;}
		//public legend legend{get;set;}
		public chart chart{get;set;}
		public class text{
		public String label{get;set;}
	}
	public class tasks{
		public list<task> task{get;set;}
	}
	public class task{
		//public String id{get;set;}
		public String enddate{get;set;}
		public String color{get;set;}
		public String start{get;set;}
		//public String height{get;set;}
		//public String processid{get;set;}
		//public String toppadding{get;set;}
		//public String label{get;set;}
	}
	public class processes{
		public list<process> process{get;set;}
		/*public String align{get;set;}
		public String headerfontsize{get;set;}
		public String isbold{get;set;}
		public String headerfontcolor{get;set;}
		public String bgalpha{get;set;}
		public String headerbgcolor{get;set;}
		public String isanimated{get;set;}
		public String bgcolor{get;set;}
		public String fontsize{get;set;}
		public String headervalign{get;set;}
		public String fontcolor{get;set;}
		public String headeralign{get;set;}
		public String headertext{get;set;}*/
	}
	public class process{
		public String label{get;set;}
		public String id{get;set;}
	}
	/*public class legend{
		public list<item> item{get;set;}
	}
	public class item{
		public String label{get;set;}
		public String color{get;set;}
	}*/
	public class datatable{
		/*public String namealign{get;set;}
		public String fontsize{get;set;}
		public String fontcolor{get;set;}
		public String valign{get;set;}
		public String showprocessname{get;set;}
		public String align{get;set;}
		public String headervalign{get;set;}
		public String headerfontcolor{get;set;}
		public String headerfontsize{get;set;}
		public String headerbgcolor{get;set;}*/
		public list<datacolumn> datacolumn{get;set;}
		//public String headeralign{get;set;}
	}
	public class datacolumn{
		//public String bgcolor{get;set;}
		public list<text> text{get;set;}
		public String headertext{get;set;}
	}
	public class chart{
		public String dateformat{get;set;}
		public String subcaption{get;set;}
		public String caption{get;set;}
		public String useVerticalScrolling{get;set;}
	}
	public class category{
		//public String fontsize{get;set;}
		public String label{get;set;}
		public String align{get;set;}
		public String enddate{get;set;}
		//public String fontcolor{get;set;}
		public String start{get;set;}
	}
	public class categories{
		public list<category> category{get;set;}
	}
}