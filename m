From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Multiistreaming playback and unsolicited event of hp
	jack
Date: Fri, 22 Apr 2011 08:27:36 +0800
Message-ID: <BANLkTinDeiJhA0=ovSv6xPrka0dH_jLS+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 051CA103959
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Apr 2011 02:27:39 +0200 (CEST)
Received: by fxm5 with SMTP id 5so170508fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2011 17:27:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

There are several bug report related to VT1708S independent hp

https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5344

Is it a bug of the driver to create an "independent hp switch" and enable
unsolicited event at HP jack for (HP automute speaker) for the desktop
motherboard with 6 audio jack at rear panel and without internal speaker ?

http://www.intel.com/support/motherboards/desktop/sb/cs-020642.htm#multistream

Does some of the notebook also support multistreaming or just only the
desktop ?
