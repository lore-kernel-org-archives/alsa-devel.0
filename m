From: Wu Fengguang <wfg@linux.intel.com>
Subject: [PATCH 0/7] minor HDMI cleanups and fixes
Date: Sat, 22 Nov 2008 09:40:50 +0800
Message-ID: <20081122014050.348491872@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id A87A51037F6
	for <alsa-devel@alsa-project.org>; Sat, 22 Nov 2008 04:08:59 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi,

Here are another set of HDMI cleanups and fixes.

        [PATCH 1/7] hda - minor HDMI code cleanups
        [PATCH 2/7] hda - report selected CA index for Audio InfoFrame
        [PATCH 3/7] hda - make HDMI messages more user friendly
        [PATCH 4/7] hda - ELD proc interface write updates
        [PATCH 5/7] hda - document the ELD proc interface
        [PATCH 6/7] hda - fix DisplayPort naming
        [PATCH 7/7] hda - fix build warning when CONFIG_PROC_FS=n


Thanks,
Fengguang
-- 
