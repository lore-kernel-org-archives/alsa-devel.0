From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [Uclinux-dist-devel] [PATCH 1/4] extend ad1938
 codec driver to ad193x supporting ad1936/7/8/9
Date: Fri, 19 Mar 2010 09:03:49 +0000
Message-ID: <1268989429.3757.13.camel@odin>
References: <1268900221-6833-1-git-send-email-21cnbao@gmail.com>
	<1268902095.3773.6.camel@odin>
	<3c17e3571003180208y34e4b5dekd2d23efa0723b641@mail.gmail.com>
	<20100318111848.GB3080@opensource.wolfsonmicro.com>
	<8bd0f97a1003180857vdd155e0o29684b50cbd5e34e@mail.gmail.com>
	<20100318162017.GA6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181017xba8e1a9oce2d40bf56818956@mail.gmail.com>
	<20100318180516.GF6142@rakim.wolfsonmicro.main>
	<8bd0f97a1003181108y3f7f5871t81c5cd5ba0c6312d@mail.gmail.com>
	<3c17e3571003182030mc8ea095u2298f008fbcbee8e@mail.gmail.com>
	<3c17e3571003190007p61929e99y4db8f5545e777401@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D4F1F1037EE
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 10:03:54 +0100 (CET)
Received: by gyd10 with SMTP id 10so1452859gyd.38
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 02:03:53 -0700 (PDT)
In-Reply-To: <3c17e3571003190007p61929e99y4db8f5545e777401@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, yi.li@analog.com, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 2010-03-19 at 15:07 +0800, Barry Song wrote:
> It seems "git-format-patch -M" fails to detect this patch as a
> rename(maybe due to too many changed lines?), so I commit two times to
> get a readable patch and attach them.
> 1. rename ad1938 to ad193x
> 2. extend ad1938 codec driver to ad193x supporting ad1936/7/8/9
> -barry

Attached patches look fine.

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
