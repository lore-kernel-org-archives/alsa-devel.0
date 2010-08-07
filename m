From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [Uclinux-dist-devel] [PATCH 2/6] ASoC: Blackfin:
	new machine driver for ADAU1361 codecs
Date: Sat, 7 Aug 2010 23:29:24 +0100
Message-ID: <FB9CDF75-F284-4D03-AB3A-CE3692EB8969@opensource.wolfsonmicro.com>
References: <1281212905-12957-1-git-send-email-vapier@gentoo.org>
	<1281212905-12957-2-git-send-email-vapier@gentoo.org>
	<AC17F0B0-A138-46D6-B0A7-2752D291BA03@opensource.wolfsonmicro.com>
	<AANLkTikTQ=dhDPy33dcjKmm7EfQ8KVZhA2aRdCY3Ms84@mail.gmail.com>
	(sfid-20100807_221500_762224_CB34E945)
Mime-Version: 1.0 (iPad Mail 7B405)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3ADDE103806
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 00:29:04 +0200 (CEST)
In-Reply-To: <AANLkTikTQ=dhDPy33dcjKmm7EfQ8KVZhA2aRdCY3Ms84@mail.gmail.com>
	(sfid-20100807_221500_762224_CB34E945)
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
Cc: "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Cliff Cai <cliff.cai@analog.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 7 Aug 2010, at 22:14, Mike Frysinger <vapier.adi@gmail.com> wrote:

> On Sat, Aug 7, 2010 at 17:08, Mark Brown wrote:

>> It'd be really helpful if you could do a bit more pre-review on the stuff you're posting, especially where you've got a bunch of drivers that follow similar patterns and are going to generate exactly the same feedback. Posting a large batch of patches at once isn't a problem but if you're sending additional patches later on it'd be helpful to take into account the feedback that has already been given on prior serieses.
> 

> probably, but i'm not familiar with the ASoC stuff to fix/review any
> of this.  i'll open another tracker item for these codecs.

It'd probably be enough to just avoid posting additional batches of patches without incorporating previous review, either by just posting everything in one series or by holding off on later ones after getting the first batch of review. The reason I mentioned this was that I'd already reviewed previous postings (and seen that you'd read my review) but was noticing many of the same issues cropping up in the new postings.
