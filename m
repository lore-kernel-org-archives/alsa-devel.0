From: Nicolin Chen <b42378@freescale.com>
Subject: Re: [PATCH] ASoC: soc-pcm: fix incorrect channels and
 sample_bits wiping off
Date: Wed, 20 Nov 2013 10:06:56 +0800
Message-ID: <20131120020655.GC11009@MrMyself>
References: <1384855074-17596-1-git-send-email-b42378@freescale.com>
 <20131119191119.GO2674@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 12FE2261A3C
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 03:25:59 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131119191119.GO2674@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 19, 2013 at 07:11:19PM +0000, Mark Brown wrote:
> On Tue, Nov 19, 2013 at 05:57:54PM +0800, Nicolin Chen wrote:
> 
> > Sir, I find the previous symmetry patch hasn't been merged into for-next.
> > So are you willing to apply this one or let me refine the previous PATCH
> > and resend that one?
> 
> I applied this but squashed it down into the previous patch which is
> probably what the resend would've done.

Exactly. Thank you, sir.
Nicolin Chen
