From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Audio driver for OMAP 730 based board - hpw to
	migrate from OSS to ALSA
Date: Thu, 17 May 2007 18:54:20 +0530
Message-ID: <61445c750705170624h512ca734s90f5624a3029c64f@mail.gmail.com>
References: <61445c750705160518i6a6d96dfr6757576e6b3bbd11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 29F7D243FA
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 15:24:23 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so518881wri
	for <alsa-devel@alsa-project.org>; Thu, 17 May 2007 06:24:21 -0700 (PDT)
In-Reply-To: <61445c750705160518i6a6d96dfr6757576e6b3bbd11@mail.gmail.com>
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

After seeing the sources I gathered that there is no support for these
OMAPs, but generic audio handling drivers for OMAPs are available. Any
idea or pointers regarding how to get started will be
helpful.

Regards,
Pharaoh.

On 5/16/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hi
> I am new here and have slight idea about the Linux audio drivers.
> I am working on OMAP 730 based p2-sample board. AFAIK, there is no audio
> driver support for this board. I have found
> 2.4 drivers for the same board which I have ported to 2.6, but it is an OSS
> driver.
>
> So, the questions:
>
> 1. Has anyone written audio drivers for the above mentioned board? Any plans
> to make them open source? Any pointers will be useful regarding the same.
>
> 2. How should I go about migrating the OSS driver to ALSA, if something like
> this is necessary?
>
> 3. Any resources which will be helpful for writing ALSA drivers?
>
>
> Thanks & regards,
> Pharaoh.
>
