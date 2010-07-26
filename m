From: Jiri Slaby <jirislaby@gmail.com>
Subject: hda_intel: too quiet sound (regression)
Date: Mon, 26 Jul 2010 16:42:34 +0200
Message-ID: <4C4D9EDA.3060505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) by alsa0.perex.cz (Postfix) with ESMTP id 1AA032473F
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 16:42:45 +0200 (CEST)
Received: by bwz4 with SMTP id 4so3000489bwz.38
	for <alsa-devel@alsa-project.org>; Mon, 26 Jul 2010 07:42:44 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, fengguang.wu@intel.com, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi,

after I upgraded from 2.6.34-rc5-mm1 to 2.6.35-rc5-mm1 (there were other
issues in between them), the sound from my soundcard is very very quiet.

alsa-info:
http://www.alsa-project.org/db/?f=dcadb29a2d5d047ecf5545792ac3239dc0c8c7f0

Any ideas?

thanks,
-- 
js
