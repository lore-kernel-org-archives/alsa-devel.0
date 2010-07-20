From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 1/3] ASoC: multi-component - Add Aquila
	sound driver
Date: Wed, 21 Jul 2010 07:50:36 +0900
Message-ID: <4C46283C.6070102@samsung.com>
References: <4C4533FC.8050407@samsung.com>
	<20100720090303.GK10222@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by alsa0.perex.cz (Postfix) with ESMTP id CCECF2436E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 00:50:39 +0200 (CEST)
Received: from epmmp2 (mailout3.samsung.com [203.254.224.33])
	by mailout3.samsung.com
	(Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12
	2010)) with ESMTP id <0L5V005LLOSC1A90@mailout3.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 21 Jul 2010 07:50:36 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
	by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
	2004)) with ESMTPA id <0L5V000RQOSC24@mmp2.samsung.com> for
	alsa-devel@alsa-project.org; Wed, 21 Jul 2010 07:50:36 +0900 (KST)
In-reply-to: <20100720090303.GK10222@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Joonyoung Shim <jy0922.shim@samsung.com>, Jassi Brar <jassisinghbrar@gmail.com>, Seungwhan Youn <claude.youn@gmail.com>, Kyungmin Park <kyungmin.park@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Tue, Jul 20, 2010 at 02:28:28PM +0900, Chanwoo Choi wrote:
>> This patch add sound support for the Aquila board based on S5PC110.
>>
>> The Aquila board is based on Samsung SoC(S5PC110) and include
>> WM8994 codec over I2S to support sound. This uses the I2Sv4 driver
>> compatible with I2Sv5 to run sound.
> 
> Once you've made the correction requested by Mr. Youn:
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> 
Ok, I will again send modified patch.

Thanks you,
Chanwoo Choi
