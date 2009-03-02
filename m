From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] ASoC: make ops a pointer in 'struct
	snd_soc_dai'
Date: Mon, 02 Mar 2009 12:15:57 -0600
Message-ID: <49AC225D.6090002@freescale.com>
References: <f17812d70903011925w2a201e27m39fa001d4c700d45@mail.gmail.com>	
	<ed82fe3e0903020439u497389ccp7ec35c7de37ad936@mail.gmail.com>
	<f17812d70903020646q15d43dcch8ad90df2cb486499@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id BCD932440B
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 19:15:59 +0100 (CET)
In-Reply-To: <f17812d70903020646q15d43dcch8ad90df2cb486499@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@kernel.org>
List-Id: alsa-devel@alsa-project.org

Eric Miao wrote:

>  sound/soc/fsl/fsl_ssi.c          |   18 ++++---

I think you forgot sound/soc/fsl/mpc5200_psc_i2s.c

-- 
Timur Tabi
Linux kernel developer at Freescale
