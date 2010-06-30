<%
/**
 * Copyright (c) 2000-2010 Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>

<%@ include file="/init.jsp" %>

<%
PortletPreferences preferences = renderRequest.getPreferences();

if (Validator.isNotNull(portletResource)) {
	preferences = PortletPreferencesFactoryUtil.getPortletSetup(request, portletResource);
}

String articlesTitle = preferences.getValue("articles-title", StringPool.BLANK);
int articlesDelta = GetterUtil.getInteger(preferences.getValue("articles-delta", StringPool.BLANK), SearchContainer.DEFAULT_DELTA);
String articlesDisplayStyle = preferences.getValue("articles-display-style", "title");
String articleWindowState = preferences.getValue("article-window-state", WindowState.MAXIMIZED.toString());
String childArticlesDisplayStyle = preferences.getValue("child-articles-display-style", "abstract");
boolean enableArticleComments = GetterUtil.getBoolean(preferences.getValue("enable-article-comments", null), true);
boolean enableArticleCommentRatings = GetterUtil.getBoolean(preferences.getValue("enable-article-comment-ratings", null));

String selectionMethod = preferences.getValue("selection-method", "parent-group");
long[] scopeGroupIds = GetterUtil.getLongValues(preferences.getValues("scope-group-ids", new String[0]));
long[] resourcePrimKeys = GetterUtil.getLongValues(preferences.getValues("resource-prim-keys", new String[0]));

boolean allArticles = GetterUtil.getBoolean(preferences.getValue("all-articles", null), true);
String orderByColumn = preferences.getValue("order-by-column", "modified-date");
boolean orderByAscending = GetterUtil.getBoolean(preferences.getValue("order-by-ascending", null));

int rssDelta = GetterUtil.getInteger(preferences.getValue("rss-delta", StringPool.BLANK), SearchContainer.DEFAULT_DELTA);
String rssDisplayStyle = preferences.getValue("rss-display-style", RSSUtil.DISPLAY_STYLE_FULL_CONTENT);
String rssFormat = preferences.getValue("rss-format", "atom10");

String rssFormatType = RSSUtil.getFormatType(rssFormat);
double rssFormatVersion = RSSUtil.getFormatVersion(rssFormat);

OrderByComparator orderByComparator = null;

if (orderByColumn.equals("create-date")) {
	orderByComparator = new ArticleCreateDateComparator(orderByAscending);
}
else if (orderByColumn.equals("modified-date")) {
	orderByComparator = new ArticleModifiedDateComparator(orderByAscending);
}
else if (orderByColumn.equals("priority")) {
	orderByComparator = new ArticlePriorityComparator(orderByAscending);
}
else if (orderByColumn.equals("title")) {
	orderByComparator = new ArticleTitleComparator(orderByAscending);
}

if (articleWindowState.equals(WindowState.MAXIMIZED.toString()) && windowState.equals(WindowState.MAXIMIZED)) {
	PortletURL portletURL = renderResponse.createRenderURL();

	portletURL.setWindowState(WindowState.NORMAL);

	portletDisplay.setURLBack(HttpUtil.removeParameter(portletURL.toString(), renderResponse.getNamespace() + "jspPage"));
}
%>