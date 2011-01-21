From: pl bossart <bossart.nospam@gmail.com>
Subject: Re: UCM questions
Date: Fri, 21 Jan 2011 15:03:37 -0600
Message-ID: <AANLkTi=V9ouox2vp5VYA+_gmsOCCecBKOjpd58DsuaxK@mail.gmail.com>
References: <AANLkTim72DeHVzx3kmgF59EQQwC8jHAVpMZnt+kVTddX@mail.gmail.com>
	<20110121113744.GA18682@sirena.org.uk>
	<1295623491.3348.284.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D86B24374
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 22:03:38 +0100 (CET)
Received: by iwb12 with SMTP id 12so2299588iwb.38
	for <alsa-devel@alsa-project.org>; Fri, 21 Jan 2011 13:03:37 -0800 (PST)
In-Reply-To: <1295623491.3348.284.camel@odin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

> Originally, verbs were mapped 1:1 with cards, however Jaroslav recently
> added support for multiple cards per verb.

Does this mean for a given verb UCM will return a list of devices on
different cards that can be used, and the application will choose from
the list? Or are these multiple cards supposed to be used
simultaneously?
I probably need more expresso here..
