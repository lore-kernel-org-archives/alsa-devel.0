From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 01/10] ASoC: build fix for
	snd_soc_info_bool_ext
Date: Tue, 13 May 2008 14:41:12 +0100
Message-ID: <20080513134112.GF21292@sirena.org.uk>
References: <1210678815-9755-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<s5h63tie3ba.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 239BE24B0E
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 15:41:13 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h63tie3ba.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 13, 2008 at 03:33:45PM +0200, Takashi Iwai wrote:

> Applied all patches to ALSA tree.  The first one was already applied
> directly to be pushed to the upstream at the next time.

Thanks.

FWIW I'm currently basing my patches against the mm branch of:

   git://git.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git

so I will automagically drop anything that appears in hg.  Is there
anything better to use?
