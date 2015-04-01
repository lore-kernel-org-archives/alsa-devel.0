From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 25/25] sound: wm5100-tables: Use bool function return
	values of true/false not 1/0
Date: Wed, 1 Apr 2015 12:54:16 +0100
Message-ID: <20150401115416.GC5442@opensource.wolfsonmicro.com>
References: <cover.1427759009.git.joe@perches.com> <9340bd2566359c81dd562496b08408f167e9f7d3.1427759010.git.joe@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9340bd2566359c81dd562496b08408f167e9f7d3.1427759010.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 30, 2015 at 04:46:23PM -0700, Joe Perches wrote:
> Use the normal return values for bool functions
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---

Commit message is a little unusual, I would have expected
something more like "ASoC: wm5100: ....", but patch looks fine:

Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

Thanks,
Charles
