From: Timur Tabi <timur@freescale.com>
Subject: Cirrus Logic CS4270 support coming soon
Date: Tue, 17 Jul 2007 22:16:05 -0500
Message-ID: <469D85F5.2040901@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 143CD103849
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jul 2007 05:15:25 +0200 (CEST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6I3FKPG026046
	for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2007 20:15:23 -0700 (MST)
Received: from Artemis.local (mvp-10-214-72-238.am.freescale.net
	[10.214.72.238])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6I3FJBU003164
	for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2007 22:15:19 -0500 (CDT)
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
List-Id: alsa-devel@alsa-project.org

Hi Everyone,

I just wanted to let everyone know that I will soon be submitting an ASoC driver for the Cirrus Logic CS4270 codec.  I have the driver working in-house on an older version of ALSA.  As soon as I finish work on my current project, I will clean up the driver, update to the latest code, and submit it.

If anyone is using this codec on their hardware, please let me know.  The CS4270 supports many different configurations, but my board only enables some of them.
