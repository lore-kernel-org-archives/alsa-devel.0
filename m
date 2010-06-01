From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH v3 0/5]  OMAP/ASoC: McBSP: FIFO handling related fixes
Date: Tue, 1 Jun 2010 14:40:46 +0300
Message-ID: <20100601144046.a3d20481.jhnikula@gmail.com>
References: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1275391104-26387-1-git-send-email-peter.ujfalusi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk, tony@atomide.com, ext-eero.nurkkala@nokia.com, eduardo.valentin@nokia.com
List-Id: alsa-devel@alsa-project.org

On Tue,  1 Jun 2010 14:18:19 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Hello,
> 
> Changes since RFC v2:
> - Comments added explaining the changes, and documenting the API in patch2
> - In patch5:
>  - Variable names changed in the hw_rule function
>  - hw_rule function got renamed
>  - The snd_pcm_hw_rule_add calls moved so it anly got set on OMAP3
> 
To whole series:

Acked-by: Jarkko Nikula <jhnikula@gmail.com>
