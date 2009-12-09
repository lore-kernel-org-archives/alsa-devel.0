From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: [PATCH] Add direct git link to grub hda-analyzer
Date: Wed,  9 Dec 2009 09:42:07 +0100
Message-ID: <1260348127-10868-1-git-send-email-bug-track@fisher-privat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id BEDFD245C5
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 09:42:13 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Alexey Fisher <bug-track@fisher-privat.net>
List-Id: alsa-devel@alsa-project.org

Just to save some time, add direct git link to grub hda-analyzer

Signed-off-by: Alexey Fisher <bug-track@fisher-privat.net>

	modified:   Documentation/sound/alsa/HD-Audio.txt
---
 Documentation/sound/alsa/HD-Audio.txt |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/alsa/HD-Audio.txt b/Documentation/sound/alsa/HD-Audio.txt
index 7b8a5f9..6325bec 100644
--- a/Documentation/sound/alsa/HD-Audio.txt
+++ b/Documentation/sound/alsa/HD-Audio.txt
@@ -624,11 +624,13 @@ hda-verb.  The program gives you an easy-to-use GUI stuff for showing
 the widget information and adjusting the amp values, as well as the
 proc-compatible output.
 
-The hda-analyzer is a part of alsa.git repository in
-alsa-project.org:
+The hda-analyzer:
 
 - http://git.alsa-project.org/?p=alsa.git;a=tree;f=hda-analyzer
 
+is a part of alsa.git repository in alsa-project.org:
+
+- git://git.alsa-project.org/alsa.git
 
 Codecgraph
 ~~~~~~~~~~
-- 
1.6.3.3
