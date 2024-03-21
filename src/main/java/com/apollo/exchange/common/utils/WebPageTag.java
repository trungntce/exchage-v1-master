package com.apollo.exchange.common.utils;

import com.apollo.exchange.common.dto.PageDTO;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;

public class WebPageTag extends TagSupport {

	private static final long serialVersionUID = -240249619261555015L;
	private String script = "goPage";
	private PageDTO page;

	@Override
	public int doStartTag() throws JspException {
		

        if (page == null) {
            return SKIP_BODY;
        }

        String content = paging( page.getTotal(), page.getLimit(), page.getNavi(), page.getPage() , script);
        try {
			pageContext.getOut().println(content);
		} catch (IOException e) {
			e.printStackTrace();
		}
        return SKIP_BODY;
	}

	public String getScript() {
		return script;
	}

	public void setScript(String script) {
		this.script = script;
	}

	public PageDTO getPage() {
		return page;
	}

	public void setPage(PageDTO page) {
		this.page = page;
	}

	private String paging(int totalCnt, int rowRange, int pageRange, int curPage, String script) {

		if( script.isEmpty() )
			script = "goPage";

		String path = SecuritySession.getCurrentRequest().getContextPath();
		if( path.equals("/") )
			path = "";

		StringBuffer sb = new StringBuffer();

		if( totalCnt == 0 )	return "";

		long pageCnt = totalCnt % rowRange;

		if( pageCnt == 0 )
			pageCnt = totalCnt / rowRange;
		else
			pageCnt = totalCnt / rowRange + 1L;

		long totalPage = pageCnt;

		long rangeCnt = curPage / pageRange;
		if( curPage % pageRange == 0 )
			rangeCnt = curPage / pageRange -1L;

		sb.append("<div class=\"paging-wrap\"><ul class=\"pagination justify-content-center\">\n");

		long firstPage = curPage - pageRange;
//		if( firstPage > 0 ) {
//			sb.append("<li><a href=\"javascript:"+script+"('1');\" class=\"page-link\" val='1'>&#171;</a></li>");
//		}

		if( curPage > 1 ) {
			sb.append("<li class=\"page-item\" onclick=\"javascript:"+script+"('1');\">").append("<a class=\"page-link\">&#60;&#60;</a></li>");
			sb.append("<li class=\"page-item\" onclick=\"javascript:"+script+"('").append(curPage-1).append("');\">").append("<a class=\"page-link\">&#60;</a></li>");
		}

		for( long i = rangeCnt * pageRange + 1L ; i < (rangeCnt + 1L) * pageRange + 1L ; i++) {

			if( i == curPage )
				sb.append("<li  class=\"page-item active\">").append("<a class=\"page-link\">").append(i).append("</a></li>");
			else if( i > 10)
				sb.append("<li class=\"page-item\" onclick=\""+script+"('").append(i).append("');\">").append("<a class=\"page-link\">").append(i).append("</a></li>");
			else
				sb.append("<li class=\"page-item\" onclick=\""+script+"('").append(i).append("');\">").append("<a class=\"page-link\">").append(i).append("</a></li>");

			if( i == pageCnt )
				break;
		}

		long page = (rangeCnt+1L) * pageRange + 1L;
		if(page > pageCnt ) page = pageCnt;


		if( curPage >= 1 && totalCnt > 1 && curPage != pageCnt ) {
			sb.append("<li class=\"page-item\" onclick=\""+script+"('").append(curPage+1).append("');\">").append("<a class=\"page-link\">&#62;</a></li>");
			sb.append("<li class=\"page-item\" onclick=\""+script+"('").append(totalPage).append("');\">").append("<a class=\"page-link\">&#62;&#62;</a></li>");

		}

//		if( totalPage < pageCnt ) {
//			sb.append("<li><a href=\"javascript:"+script+"('").append(totalPage).append("');\" class=\"page-link\" val='1'>&#187;</a></li>");
//		}

		sb.append("\n</ul></div>");
		return sb.toString();
	}
}

