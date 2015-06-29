From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 3/3] docs: Add UCM link to main doxygen page.
Date: Mon, 29 Jun 2015 16:25:59 +0100
Message-ID: <1435591559-6277-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435591559-6277-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BD0E26172C
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 17:26:13 +0200 (CEST)
In-Reply-To: <1435591559-6277-1-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 doc/index.doxygen | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/index.doxygen b/doc/index.doxygen
index 45aa68a..7d049fe 100644
--- a/doc/index.doxygen
+++ b/doc/index.doxygen
@@ -40,6 +40,7 @@ may be placed in the library code instead of the kernel driver.</P>
   <LI>Page \ref rawmidi explains the design of the RawMidi API.
   <LI>Page \ref timer explains the design of the Timer API.
   <LI>Page \ref seq explains the design of the Sequencer API.
+  <LI>Page \ref ucm explains the use case API.
 </UL>
 
 <H2>Configuration</H2>
-- 
2.1.4
