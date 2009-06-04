From: "Cai, Cliff" <Cliff.Cai@analog.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/5] ASoC codec:
	SSM2602: assign last substream to the master when shutting down
Date: Thu, 4 Jun 2009 16:56:18 +0800
Message-ID: <0F1B54C89D5F954D8535DB252AF412FA04257CAD@chinexm1.ad.analog.com>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
	<1243916337-29953-2-git-send-email-vapier@gentoo.org>
	<20090603105223.GE11507@sirena.org.uk>
	<8bd0f97a0906030537y1e65aa7atec4b0c5cdf4ae2f@mail.gmail.com>
	<20090603145316.GA7315@rakim.wolfsonmicro.main>
	<8bd0f97a0906031826j647efa0bs1ffb6492cfd0ccd8@mail.gmail.com>
	<4A2782FE.3080103@gmail.com>
	<8bd0f97a0906040122r2e4ca8feo69e6afb06140cef3@mail.gmail.com>
	<0F1B54C89D5F954D8535DB252AF412FA04257C3B@chinexm1.ad.analog.com>
	<8bd0f97a0906040145j3b0389c2i24a062504ad8a337@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nwd2mail10.analog.com (nwd2mail10.analog.com [137.71.25.55])
	by alsa0.perex.cz (Postfix) with ESMTP id 603041037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 10:52:45 +0200 (CEST)
Content-Class: urn:content-classes:message
In-Reply-To: <8bd0f97a0906040145j3b0389c2i24a062504ad8a337@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Karl Beldan <karl.beldan@gmail.com>, uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

 

>-----Original Message-----
>From: Mike Frysinger [mailto:vapier.adi@gmail.com] 
>Sent: Thursday, June 04, 2009 4:46 PM
>To: Cai, Cliff
>Cc: Karl Beldan; Mark Brown; 
>uclinux-dist-devel@blackfin.uclinux.org; alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] [Uclinux-dist-devel] [PATCH 2/5] 
>ASoC codec: SSM2602: assign last substream to the master when 
>shutting down
>
>On Thu, Jun 4, 2009 at 04:31, Cai, Cliff wrote:
>> The blackfin tree is quite different from the latest mainline tree 
>> now,I need to make fixes against the mainline tree And resend the 
>> patches
>
>i wouldnt bother.  2.6.30 is going to be out shortly and i'll 
>update our tree to that soon after.


Then,should I re-make the patches against the mainline tree right
now(I've cloned the mainline tree locally)
 or wait untill you've updated blackfin tree?

Cliff  
