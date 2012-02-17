From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH 1/2] ASoC: core - Add direct mapping
 between DAIs and DAPM
Date: Fri, 17 Feb 2012 10:47:58 +0000
Message-ID: <1329475678.3972.20.camel@odin>
References: <1329321775-21082-1-git-send-email-lrg@ti.com>
	<20120215162412.GG2996@opensource.wolfsonmicro.com>
	<1329399358.28852.19.camel@odin>
	<20120216175955.GE3383@opensource.wolfsonmicro.com>
	<1329457253.24656.7.camel@vkoul-udesk3>
	<20120217054339.GB1231@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog118.obsmtp.com (na3sys009aog118.obsmtp.com
	[74.125.149.244])
	by alsa0.perex.cz (Postfix) with ESMTP id 773B9103B87
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 11:48:13 +0100 (CET)
Received: by mail-we0-f181.google.com with SMTP id p13so2134041wer.40
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2012 02:48:00 -0800 (PST)
In-Reply-To: <20120217054339.GB1231@opensource.wolfsonmicro.com>
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
Cc: Vinod Koul <vinod.koul@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2012-02-16 at 21:43 -0800, Mark Brown wrote:
> On Fri, Feb 17, 2012 at 11:10:53AM +0530, Vinod Koul wrote:
> > On Thu, 2012-02-16 at 09:59 -0800, Mark Brown wrote:
> 
> > > I *think* can get something working quickly that doesn't fill in the
> > > blanks for CODEC-CODEC links, though the conference is looking quite
> > > interesting today.  I'll try to send something later.
> 
> > On conference, when are we planing our next ASoC conference?
> 
> Not at present.  It would probably have been colocated with ELC but
> that didn't happen.

Sadly I didn't have enough time to set this up for ELC but I should have
more time after Dynamic PCM is upstream. I've had some discussions with
the Linux Foundation and they are happy to co-locate. Lets discuss when
you get back in the UK. 

Liam
