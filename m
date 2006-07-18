From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 5/5] add MAINTAINERS entry for snd-aoa
Date: Tue, 18 Jul 2006 19:28:46 +0200
Message-ID: <16875.2972771928$1153248227@news.gmane.org>
References: <20060718172841.046446000@sipsolutions.net>>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 80E52245
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 20:43:23 +0200 (MEST)
Content-Disposition: inline; filename=aoa-maintainer.patch
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: linuxppc-dev@ozlabs.org
Cc: benh@kernel.crashing.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This adds me into the MAINTAINERS file for the AOA driver.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-fetch.orig/MAINTAINERS	2006-07-18 13:39:52.543476868 +0200
+++ linux-2.6-fetch/MAINTAINERS	2006-07-18 13:57:27.843476868 +0200
@@ -292,6 +292,13 @@ L:	info-linux@geode.amd.com
 W:	http://www.amd.com/us-en/ConnectivitySolutions/TechnicalResources/0,,50_2334_2452_11363,00.html
 S:	Supported
 
+AOA (Apple Onboard Audio) ALSA DRIVER
+P:	Johannes Berg
+M:	johannes@sipsolutions.net
+L:	linuxppc-dev@ozlabs.org
+L:	alsa-devel@alsa-project.org
+S:	Maintained
+
 APM DRIVER
 P:	Stephen Rothwell
 M:	sfr@canb.auug.org.au

--


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
