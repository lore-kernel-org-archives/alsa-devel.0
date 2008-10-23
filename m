From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: ASOC on OMAP3+twl4030
Date: Thu, 23 Oct 2008 12:11:37 +0530
Message-ID: <ef0d8a250810222341i54fe3d97mbc90003f2d07acb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.158])
	by alsa0.perex.cz (Postfix) with ESMTP id EA8C924416
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 08:41:55 +0200 (CEST)
Received: by yw-out-1718.google.com with SMTP id 9so70454ywk.2
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 23:41:37 -0700 (PDT)
Content-Disposition: inline
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

Hello all,
I am reporting an issue for last 4 days and i am not getting enough response
fromt he mailing list.

My issue is with the asoc drivers for omap3 and twl4030 combination which
are available in the latest git kernel.

Audio is working on my custom board when i boot out of MMC but the same
setup (x-laod, u-boot and uImage and hadware)  the audio is not working when
i boot out of NAND.

Can any one help me in debugging the issue.

Background:
I am using 2.6.26 linux kernel i have ported soc stuff from 2.6.27 latest
git kernel for omap3 mcbsp and twl4030 codec support.. the audio is working
when i use it on OMAP3EVM even though it is booted out of NAND.

I am getting very less replies against my issue am i posting to wrong people
or what
can any one tell me how can i make use of this mailing list to its fullest
-- 
Thank You all,
Neyo.
