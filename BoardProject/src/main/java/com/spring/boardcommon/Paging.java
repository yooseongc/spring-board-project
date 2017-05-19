package com.spring.boardcommon;

public class Paging {
	
	public static void setPage(PagingVO pvo) {
		
		int page = Util.nvl(pvo.getPage(), 1);
		int pageSize = Util.nvl(pvo.getPageSize(), 10);
		
		if (pvo.getPage() == null) {
			pvo.setPage(page + "");
		}
		if (pvo.getPageSize() == null) {
			pvo.setPageSize(pageSize + "");
		}
		
		int start_row = (page - 1) * pageSize + 1;
		int end_row = (page - 1) * pageSize + pageSize;
		
		pvo.setStart_row(start_row + "");
		pvo.setEnd_row(end_row + "");
	}
	
}
