From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/2] ARM: S5PV210: Add the GPIO lib
Date: Wed, 28 Jul 2010 17:54:38 +0900
Message-ID: <4C4FF04E.6010101@samsung.com>
References: <4C4F9E4D.4090608@samsung.com>
	<005501cb2e2c$304d4480$90e7cd80$%szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id 75212243BB
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Jul 2010 10:54:42 +0200 (CEST)
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L6900HBUFF36140@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 28 Jul 2010 17:54:39 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L6900DM7FF385@mmp1.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 28 Jul 2010 17:54:39 +0900 (KST)
In-reply-to: <005501cb2e2c$304d4480$90e7cd80$%szyprowski@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: alsa-devel@alsa-project.org, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Joonyoung Shim' <jy0922.shim@samsung.com>, 'Mark Brown' <broonie@opensource.wolfsonmicro.com>, 'Ben Dooks' <ben@simtec.co.uk>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'linux-samsung-soc' <linux-samsung-soc@vger.kernel.org>, 'linux-arm-kernel' <linux-arm-kernel@lists.infradead.org>, 'Liam Girdwood' <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Marek Szyprowski wrote:
> Hello,
> 
> On Wednesday, July 28, 2010 5:05 AM Chanwoo Choi wrote:
> 
>> This patch add the definition of GPIO to support WM8994 audio codec on
>> I2C bus.
> 
> I've already submitted similar patch that does this job correctly. See:
> http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git;a=commit;h=d67
> d303c159aca6db11fb9a03068f52cbf7c145d
> 
Ah~, I haven't checked your patch.
I will only send the patch which support audio on Goni/Aquila board.
