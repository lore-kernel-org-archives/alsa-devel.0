From: Kristoffer Janke <kj@conceptT.com>
Subject: Re: No sound/mixer with new laptops on board sound -
 hda_intel ALC883
Date: Sat, 26 Apr 2008 20:14:46 +0200
Message-ID: <48137116.5000205@conceptT.com>
References: <4811F915.60208@conceptT.com> <48132869.9080203@conceptT.com>
	<48136925.1080900@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.conceptT.com (unknown [84.200.19.22])
	by alsa0.perex.cz (Postfix) with ESMTP id B948124577
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Apr 2008 20:17:00 +0200 (CEST)
Received: from [192.168.1.210] (dslb-088-077-211-200.pools.arcor-ip.net
	[88.77.211.200])
	by mail.conceptT.com (Postfix) with ESMTP id D4F8D642DEF
	for <alsa-devel@alsa-project.org>;
	Sat, 26 Apr 2008 20:16:59 +0200 (CEST)
In-Reply-To: <48136925.1080900@cox.net>
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

I have alsa-utils installed, but alsamixer does not run, instead it 
gives this:
  ALSA lib simple_none.c:1491:(simple_add1) helem (MIXER,'Headphone 
Playback Switch',0,2,0) appears twice or more
  alsamixer: function snd_mixer_load failed: Invalid argument

So i cant modify the volumes...
