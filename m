From: "yitian" <yitian.bu@tangramtek.com>
Subject: Re: [RESEND PATCH v2 1/1] ASoC: dwc: fix dma
	stop	transferring issue
Date: Sat, 3 Oct 2015 08:39:13 +0800
Message-ID: <00a801d0fd73$ee047400$ca0d5c00$@tangramtek.com>
References: <006401d0fac5$2e4bb840$8ae328c0$@tangramtek.com>
 <20151002170544.GX12635@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg65.qq.com (smtpbg65.qq.com [103.7.28.233])
 by alsa0.perex.cz (Postfix) with ESMTP id D03D92614DA
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2015 02:39:24 +0200 (CEST)
In-Reply-To: <20151002170544.GX12635@sirena.org.uk>
Content-Language: zh-cn
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, wsa@the-dreams.de, linux-kernel@vger.kernel.org, Andrew.Jackson@arm.com, lgirdwood@gmail.com, tiwai@suse.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi Mark:
> This doesn't apply because it's been corrupted by line wrapping - git am
> can't understand it.  Since it's just that one line I fixed it up by
> hand but please look at your mail setup to make sure this works (this
> might've been what happened with your other patch yesterday).

After you said it corrupted git am, I used git send-email to send the
"correct irq clear method" patch and hopefully that was correct.
I will be careful next time, thanks a lot for your patient help.
