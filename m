From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] alsa-lib: Fix typo in comment in
	surround71.conf
Date: Tue, 19 Apr 2011 08:12:06 +0200
Message-ID: <4DAD27B6.1050002@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020709040203070604090506"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id BC06E103837
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Apr 2011 08:12:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: 591318@bugs.debian.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020709040203070604090506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

--------------020709040203070604090506
Content-Type: text/x-patch;
 name="0001-Fix-typo-in-comment-in-surround71.conf.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-Fix-typo-in-comment-in-surround71.conf.patch"

>From f79d99c91f9ed1408220aa7dc12e2ebd31339e9a Mon Sep 17 00:00:00 2001
From: David Henningsson <david.henningsson@canonical.com>
Date: Tue, 19 Apr 2011 08:05:08 +0200
Subject: [PATCH] Fix typo in comment in surround71.conf

BugLink: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=591318
Reported-by: Ariel <asdebian@dsgml.com>
Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 src/conf/pcm/surround71.conf |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/conf/pcm/surround71.conf b/src/conf/pcm/surround71.conf
index eb2360b..076a97d 100644
--- a/src/conf/pcm/surround71.conf
+++ b/src/conf/pcm/surround71.conf
@@ -7,8 +7,8 @@
 #    chn3 - rear right
 #    chn4 - center
 #    chn5 - lfe
-#    chn7 - side left
-#    chn8 - side right
+#    chn6 - side left
+#    chn7 - side right
 #
 
 pcm.!surround71 {
-- 
1.7.4.1


--------------020709040203070604090506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020709040203070604090506--
