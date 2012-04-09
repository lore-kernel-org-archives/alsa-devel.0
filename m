From: Jesper Juhl <jj@chaosbits.net>
Subject: Re: [PATCH][Trivial] Delete trailing whitespace from
 sound/soc/codecs/wm8994.c
Date: Mon, 9 Apr 2012 21:12:25 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204092109370.13925@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1204090038270.11747@swampdragon.chaosbits.net>
	<20120409103928.GB3182@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swampdragon.chaosbits.net (swampdragon.chaosbits.net
	[90.184.90.115]) by alsa0.perex.cz (Postfix) with ESMTP id 7C52E24516
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Apr 2012 21:12:26 +0200 (CEST)
In-Reply-To: <20120409103928.GB3182@opensource.wolfsonmicro.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, trivial@kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 9 Apr 2012, Mark Brown wrote:

> On Mon, Apr 09, 2012 at 12:40:32AM +0200, Jesper Juhl wrote:
> > While reading through sound/soc/codecs/wm8994.c I noticed a fair
> > amount of trailing whitespace. This patch gets rid of it.
> 
> Please try to make sure your changelog lines up with the subsysetem -
> this is especially important with trivial patches.
> 
Arrgh, sorry about that. I always forget (although not intentionally) to 
check if there's some special convention for a given subsystem :-(

I guess this would have been better:

ASoC: wm8994: Delete trailing whitespace


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
