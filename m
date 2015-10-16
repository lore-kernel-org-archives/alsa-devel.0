From: han.lu@intel.com
Subject: [PATCH V3 0/4] BAT: some fixes
Date: Fri, 16 Oct 2015 16:12:02 +0800
Message-ID: <cover.1444982584.git.han.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 32E4C26062B
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 10:14:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, liam.r.girdwood@intel.com, bernard.gautier@intel.com, alsa-devel@alsa-project.org
Cc: "Lu, Han" <han.lu@intel.com>
List-Id: alsa-devel@alsa-project.org

From: "Lu, Han" <han.lu@intel.com>

some fixes and adjusts.

Lu, Han (4):
  BAT: Merge message strings
  BAT: Use colon instead of comma for separation
  BAT: Adjust parameters and strings
  BAT: Use dynamic temp file

 bat/bat.c    | 77 +++++++++++++++++++++++++++++++++---------------------------
 bat/common.h |  2 +-
 2 files changed, 43 insertions(+), 36 deletions(-)

-- 
1.9.1
