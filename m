From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.34
Date: Thu, 8 Apr 2010 16:55:47 +0100
Message-ID: <20100408155547.GE6792@sirena.org.uk>
References: <20100408151100.GA2710@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1BB5A103984
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Apr 2010 17:55:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100408151100.GA2710@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 08, 2010 at 04:11:01PM +0100, Mark Brown wrote:
> The following changes since commit 5f712b2b73a9fc87fcc52124cfe8adefaa0c92f5:
>   Daniel Mack (1):
>         ALSA: ASoC: move dma_data from snd_soc_dai to snd_soc_pcm_stream
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

...or not, Sascha believes he's found a problem in the hrtimer stuff so
if you could hold off that'd be good.
