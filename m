From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Device-drivers-devel] [PATCH] ASoC: SSM2602: add
	SPI support
Date: Fri, 8 Apr 2011 07:14:26 +0100
Message-ID: <20110408061426.GA21700@opensource.wolfsonmicro.com>
References: <1302156311-16536-1-git-send-email-vapier@gentoo.org>
	<20110408003504.GG9827@opensource.wolfsonmicro.com>
	<BANLkTi=JYxMHf5_Xd_1VfXD=RZ8Pzb64Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 726381038D0
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Apr 2011 08:14:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTi=JYxMHf5_Xd_1VfXD=RZ8Pzb64Xw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: alsa-devel@alsa-project.org, device-drivers-devel@blackfin.uclinux.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 07, 2011 at 10:32:21PM -0400, Mike Frysinger wrote:

> sorry about that ... i was thinking there shouldnt be any conflicts in
> the codec since i'm the only one sending patches ;).  but i guess
> you're referring to just the Kconfig ?

It was just Kconfig I think.

> what git tree / branch did you merge into ?  i checked tiwai's
> sound-2.6.git and the linux-2.6-asoc.git on
> opensource.wolfsonmicro.com, but couldnt see this changeset ...

My 2.6.40 on kernel.org.
